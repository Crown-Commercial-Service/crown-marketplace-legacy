class LegalServices::RM6374::SupplierSpreadsheetCreator < LegalServices::SupplierSpreadsheetCreator
  include ActionView::Helpers::NumberHelper
  include LegalServices::RM6374::RatesHelper

  def build
    @lot = Lot.find("RM6374.#{@params['lot_number']}")

    if @params['call_off_mechanism'].nil?
      build_with_results
    else
      build_with_rates
    end
  end

  private

  def build_with_results
    Axlsx::Package.new do |package|
      add_supplier_details(package.workbook.add_worksheet(name: 'Supplier shortlist'))
      add_audit_trail(package.workbook.add_worksheet(name: 'Shortlist audit'))
    end
  end

  def build_with_rates
    Axlsx::Package.new do |package|
      add_supplier_details(package.workbook.add_worksheet(name: 'Supplier shortlist'))
      add_audit_trail(package.workbook.add_worksheet(name: 'Shortlist audit'))
      add_supplier_rates(package.workbook.add_worksheet(name: 'Supplier rates'))
    end
  end

  def add_supplier_rates(sheet)
    positions = read_positions
    headers = ['Supplier name', 'Prospectus'] + positions.map { |_, name| translate_job_title(name) }

    if @lot.number == '2'
      service_ids = Array(@params['service_numbers']).map { |num| "RM6374.#{@params['lot_number']}.#{num}" }
      services = Service.where(id: service_ids).order(:id).pluck(:id, :name)

      if @params['single_or_multiple_suppliers'] == 'single'
        add_lot_2_single_supplier_rates(sheet, positions, services, headers)
      else
        add_lot_2_multiple_supplier_rates(sheet, positions, services, headers)
      end

    else
      add_normal_supplier_rates(sheet, positions, headers)
    end
  end

  def add_lot_2_single_supplier_rates(sheet, positions, services, headers) # rubocop:disable Metrics/AbcSize
    headers[0] = 'Selected service'
    headers.delete_at(1)

    selected_supplier_frameworks.sort_by { |f| f.supplier_name.to_s.downcase }.each do |framework|
      framework_lot = framework.lots.find_by(lot_id: @lot.id)
      next if framework_lot.nil?

      sheet.add_row [framework.supplier_name, prospectus_link(framework)]
      sheet.add_row headers
      services.each do |service_id, service_name|
        rates = framework_lot.rates
                             .where(service_id:)
                             .index_by(&:position_id)

        rates_row = positions.map { |pos_id, _| display_rate(pos_id, rates) }
        sheet.add_row [service_name] + rates_row
      end
      sheet.add_row []
    end
  end

  def add_lot_2_multiple_supplier_rates(sheet, positions, services, headers) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    services.each do |service_id, service_name|
      sheet.add_row [service_name]

      supplier_rows = []

      selected_supplier_frameworks = if @params['supplier_framework_ids'].present?
                                       selected_supplier_frameworks_for_multiple_suppliers_path[service_id]
                                     else
                                       @supplier_frameworks
                                     end

      selected_supplier_frameworks.each do |framework|
        framework_lot = framework.lots.find_by(lot_id: @lot.id)
        next if framework_lot.nil?

        rates = framework_lot.rates
                             .where(service_id:)
                             .index_by(&:position_id)

        rates_row = positions.map { |pos_id, _| display_rate(pos_id, rates) }

        has_rates = rates_row.any? { |rate| rate.present? && rate != '-' }
        next unless has_rates

        supplier_rows << ([framework.supplier_name, prospectus_link(framework)] + rates_row)
      end

      if supplier_rows.any?
        sheet.add_row headers

        supplier_rows.sort_by { |row| row.first.downcase }.each { |row| sheet.add_row row }
      else
        sheet.add_row ['Contact GCA legal services category team at info@gca.gov.uk to discuss your needs.']
      end

      sheet.add_row []
    end
  end

  def add_normal_supplier_rates(sheet, positions, headers)
    sheet.add_row headers

    selected_supplier_frameworks.sort_by { |f| f.supplier_name.to_s.downcase }.each do |framework|
      framework_lot = framework.lots.find_by(lot_id: @lot.id)
      next if framework_lot.nil?

      rates = framework_lot.rates.index_by(&:position_id)
      rates_row = positions.map { |pos_id, _| display_rate(pos_id, rates) }

      sheet.add_row [framework.supplier_name, prospectus_link(framework)] + rates_row
    end
  end

  def selected_supplier_frameworks_for_multiple_suppliers_path # rubocop:disable Metrics/CyclomaticComplexity
    raw_supplier_ids = Array(@params['supplier_framework_ids']).compact_blank
    return false if raw_supplier_ids.empty?

    service_to_supplier_ids = raw_supplier_ids
                              .select { |item| item.include?(':') }
                              .map { |item| item.split(':', 2) }
                              .group_by(&:first)
                              .transform_values { |pairs| pairs.map(&:last) }

    all_selected_supplier_ids = service_to_supplier_ids.values.flatten.uniq

    frameworks_by_id = ::Supplier::Framework.joins(:supplier)
                                            .where(id: all_selected_supplier_ids)
                                            .index_by(&:id)

    service_to_supplier_ids.transform_values do |supplier_ids|
      frameworks_by_id.values_at(*supplier_ids).compact
    end
  end

  def add_supplier_details(sheet)
    sheet.add_row ['Supplier name', 'Phone number', 'Email', 'Prospectus']

    # edge case: lot 2 with multiple suppliers and no supplier framework ids selected
    selected_supplier_frameworks = if @params['supplier_framework_ids'].present? && @lot.number == '2' && @params['single_or_multiple_suppliers'] == 'multiple'
                                     selected_supplier_frameworks_for_multiple_suppliers_path.values.flatten.uniq
                                   else
                                     @supplier_frameworks
                                   end

    selected_supplier_frameworks.each do |framework|
      contact = framework.contact_detail
      sheet.add_row [
        framework.supplier_name,
        contact.telephone_number.to_s,
        contact.email,
        prospectus_link(framework)
      ]
    end
  end

  def add_audit_trail(sheet)
    sheet.add_row ['Lot', "#{@lot.number[0]} - #{@lot.name}"]

    service_ids = Array(@params['service_numbers']).map { |num| "RM6374.#{@params['lot_number']}.#{num}" }
    services = Service.where(id: service_ids).order(:id).pluck(:name)
    sheet.add_row ['Services', services.join(', ')]

    add_jurisdiction(sheet) unless @params['lot_number'] == '6'
  end

  def selected_supplier_frameworks
    ids = Array(@params['supplier_framework_ids']).compact_blank
    return @supplier_frameworks if ids.empty?

    @supplier_frameworks.select { |framework| ids.include?(framework.id) }
  end

  def read_positions
    positions = @lot.positions.order(:number)
    professions = Array(@params['professions'])

    return positions.pluck(:id, :name) if professions.blank? || professions.include?('all')

    positions.where(name: professions).pluck(:id, :name)
  end

  def prospectus_link(framework)
    framework.contact_detail.additional_details["lot_#{@lot.number}_prospectus_link"]
  end

  def translate_job_title(name)
    I18n.t("shared.rates_table.rm6374.job_titles.#{name}", default: name.humanize)
  end
end
