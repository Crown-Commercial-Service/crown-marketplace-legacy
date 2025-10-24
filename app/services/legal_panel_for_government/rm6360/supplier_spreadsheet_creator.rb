class LegalPanelForGovernment::RM6360::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  include ActionView::Helpers::NumberHelper
  include LegalPanelForGovernment::RM6360::RatesHelper

  def build
    lot = Lot.find(@params['lot_id'])

    if @params['have_you_reviewed'].nil?
      build_with_results(lot)
    else
      build_with_rates(lot)
    end
  end

  private

  def build_with_results(lot)
    Axlsx::Package.new do |package|
      add_supplier_details(package.workbook.add_worksheet(name: 'Supplier shortlist'), lot)
      add_audit_trail(package.workbook.add_worksheet(name: 'Shortlist audit'), lot)
    end
  end

  def build_with_rates(lot)
    jurisdictions = get_jurisdictions(lot)
    positions = get_positions(lot)
    supplier_details_columns = get_supplier_columns(positions, lot)

    Axlsx::Package.new do |package|
      add_audit_trail(package.workbook.add_worksheet(name: 'Shortlist audit'), lot)

      jurisdictions.each do |jurisdiction|
        worksheet_name = if jurisdiction.id == 'GB'
                           'Supplier rates'
                         else
                           "Supplier rates (#{jurisdiction.id})"
                         end

        add_supplier_rates(package.workbook.add_worksheet(name: worksheet_name), supplier_details_columns, lot, jurisdiction, positions)
      end
    end
  end

  def add_audit_trail(audit_sheet, lot)
    audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.name}"]

    add_services(audit_sheet)

    return unless lot.id.starts_with?('RM6360.4')

    add_countries(audit_sheet)
  end

  def add_supplier_details(shortlist_sheet, lot)
    shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email', 'Prospectus']

    # rubocop:disable Style/HashEachMethods
    @supplier_frameworks.each do |supplier_framework, _rates|
      shortlist_sheet.add_row(
        [
          supplier_framework.supplier_name,
          supplier_framework.contact_detail.telephone_number,
          supplier_framework.contact_detail.email,
          supplier_framework.contact_detail.additional_details["lot_#{lot.number}_prospectus_link"]
        ]
      )
    end
    # rubocop:enable Style/HashEachMethods
  end

  def add_supplier_rates(shortlist_sheet, supplier_details_columns, lot, jurisdiction, positions)
    if lot.id.starts_with?('RM6360.4')
      if @params['not_core_jurisdiction'] == 'no'
        shortlist_sheet.add_row ['Countries:', Jurisdiction.core.order(:name).pluck(:name).join('; ')]
      else
        shortlist_sheet.add_row ['Country:', jurisdiction.name]
      end
    end

    shortlist_sheet.add_row supplier_details_columns[0]

    @supplier_frameworks.zip(supplier_details_columns[1..]).map do |(_supplier_framework, rates), supplier_details_column|
      shortlist_sheet.add_row supplier_details_column + positions.map { |position_id, _position_name| display_rate(position_id, jurisdiction.id, rates) }
    end
  end

  def add_services(sheet)
    services = Service.where(id: @params['service_ids']).order(:id).pluck(:name)
    sheet.add_row ['Specialisms', services.join('; ')]
  end

  def add_countries(sheet)
    countries = if @params['not_core_jurisdiction'] == 'no'
                  Jurisdiction.core
                else
                  Jurisdiction.where(id: @params['jurisdiction_ids'])
                end.order(:name).pluck(:name)

    sheet.add_row ['Countries', countries.join('; ')]
  end

  def get_jurisdictions(lot)
    Jurisdiction.where(id: lot.id.starts_with?('RM6360.4') && @params['not_core_jurisdiction'] == 'yes' ? @params['jurisdiction_ids'] : ['GB']).order(:name)
  end

  def get_positions(lot)
    lot.positions.order(:number).pluck(:id, :name)
  end

  def get_supplier_columns(positions, lot)
    [
      ['Supplier name', 'Prospectus'] + positions.map { |_position_id, position_name| I18n.t("legal_panel_for_government.rm6360.suppliers.rates_table.job_titles.#{position_name}") }
    ] + @supplier_frameworks.map do |supplier_framework, _rates|
      [
        supplier_framework.supplier_name,
        supplier_framework.contact_detail.additional_details["lot_#{lot.number}_prospectus_link"]
      ]
    end
  end
end
