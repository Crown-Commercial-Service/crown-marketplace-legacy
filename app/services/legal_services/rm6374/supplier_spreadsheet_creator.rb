class LegalServices::RM6374::SupplierSpreadsheetCreator < LegalServices::SupplierSpreadsheetCreator
  include ActionView::Helpers::NumberHelper
  include LegalServices::RM6374::RatesHelper

  def build
    lot = Lot.find("RM6374.#{@params['lot_number']}")

    if @params['call_off_mechanism'].nil?
      build_with_results(lot)
    else
      build_with_rates(lot)
    end
  end

  private

  def build_with_results(lot)
    Axlsx::Package.new do |package|
      add_supplier_details(package.workbook.add_worksheet(name: 'Supplier shortlist'))
      add_audit_trail(package.workbook.add_worksheet(name: 'Shortlist audit'), lot)
    end
  end

  def build_with_rates(lot)
    positions = get_filtered_positions(lot)
    supplier_details_columns = get_supplier_columns(positions, lot)

    Axlsx::Package.new do |package|
      add_audit_trail(package.workbook.add_worksheet(name: 'Shortlist audit'), lot)

      sheet = package.workbook.add_worksheet(name: 'Supplier rates')
      add_supplier_rates(sheet, supplier_details_columns, positions, lot)
    end
  end

  def add_supplier_rates(shortlist_sheet, supplier_details_columns, positions, lot)
    shortlist_sheet.add_row supplier_details_columns[0]
    positions_hash = positions.to_h

    @supplier_frameworks.zip(supplier_details_columns[1..]).each do |supplier_framework, supplier_details_column|
      framework_lot = supplier_framework.lots.find_by(lot_id: lot.id)
      rates = framework_lot&.rates&.index_by(&:position_id) || {}

      position_rates = positions_hash.map { |position_id, _position_name| display_rate(position_id, rates) }

      shortlist_sheet.add_row supplier_details_column + position_rates
    end
  end

  def add_audit_trail(audit_sheet, lot)
    audit_sheet.add_row ['Lot', "#{lot.number[0]} - #{lot.name}"]

    add_services(audit_sheet)
    add_jurisdiction(audit_sheet)
  end

  def get_filtered_positions(lot)
    positions = lot.positions.order(:number)
    return positions.pluck(:id, :name) if @params['professions'].blank?

    positions.where(name: @params['professions']).pluck(:id, :name)
  end

  def get_supplier_columns(positions, lot)
    [
      ['Supplier name', 'Prospectus'] + positions.map { |_position_id, position_name| I18n.t("shared.rates_table.rm6374.job_titles.#{position_name}") }
    ] + @supplier_frameworks.map do |supplier_framework, _rates|
      [
        supplier_framework.supplier_name,
        supplier_framework.contact_detail.additional_details["lot_#{lot.number}_prospectus_link"]
      ]
    end
  end

  def add_supplier_details(shortlist_sheet)
    shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email']

    @supplier_frameworks.each do |supplier_framework|
      shortlist_sheet.add_row(
        [
          supplier_framework.supplier_name,
          supplier_framework.contact_detail.telephone_number,
          supplier_framework.contact_detail.email,
          supplier_framework.contact_detail.additional_details["lot_#{@params['lot_number']}_prospectus_link"]
        ]
      )
    end
  end

  def add_services(sheet)
    services = Service.where(id: @params['service_numbers'].map { |service_number| "RM6374.#{@params['lot_number']}.#{service_number}" }).order(:id).pluck(:name)
    sheet.add_row ['Services', services.join(', ')]
  end
end
