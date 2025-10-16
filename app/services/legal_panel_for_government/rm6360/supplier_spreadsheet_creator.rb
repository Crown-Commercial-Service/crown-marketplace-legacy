class LegalPanelForGovernment::RM6360::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def build
    super do |shortlist_sheet, audit_sheet|
      lot = Lot.find(@params['lot_id'])

      add_supplier_details(shortlist_sheet, lot)
      add_audit_trail(audit_sheet, lot)
    end
  end

  private

  def add_audit_trail(audit_sheet, lot)
    audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.name}"]

    add_services(audit_sheet)

    return unless lot.id.starts_with?('RM6360.4')

    add_countries(audit_sheet)
  end

  def add_supplier_details(shortlist_sheet, lot)
    shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email', 'Prospectus']

    @supplier_frameworks.each do |supplier_framework|
      shortlist_sheet.add_row(
        [
          supplier_framework.supplier_name,
          supplier_framework.contact_detail.telephone_number,
          supplier_framework.contact_detail.email,
          supplier_framework.contact_detail.additional_details["lot_#{lot.number}_prospectus_link"]
        ]
      )
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
end
