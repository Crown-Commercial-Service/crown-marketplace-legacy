class LegalServices::RM6374::SupplierSpreadsheetCreator < LegalServices::SupplierSpreadsheetCreator
  private

  def add_audit_trail(audit_sheet)
    lot = Lot.find("RM6374.#{@params['lot_number']}")
    audit_sheet.add_row ['Lot', "#{lot.number[0]} - #{lot.name}"]

    add_services(audit_sheet)
    add_jurisdiction(audit_sheet)
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
