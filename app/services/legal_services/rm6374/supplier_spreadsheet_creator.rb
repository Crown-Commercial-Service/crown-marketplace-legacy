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
    sheet.add_row headers

    selected_supplier_frameworks.each do |framework|
      framework_lot = framework.lots.find_by(lot_id: @lot.id)
      next if framework_lot.nil?

      rates = framework_lot.rates.index_by(&:position_id)
      rates_row = positions.map { |pos_id, _| display_rate(pos_id, rates) }

      sheet.add_row [framework.supplier_name, prospectus_link(framework)] + rates_row
    end
  end

  def add_supplier_details(sheet)
    sheet.add_row ['Supplier name', 'Phone number', 'Email', 'Prospectus']

    selected_supplier_frameworks.each do |framework|
      contact = framework.contact_detail
      sheet.add_row [
        framework.supplier_name,
        contact.telephone_number,
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
