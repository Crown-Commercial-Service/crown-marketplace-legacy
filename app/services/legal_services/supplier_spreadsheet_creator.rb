class LegalServices::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def build
    super do |shortlist_sheet, audit_sheet|
      add_supplier_details(shortlist_sheet)
      add_audit_trail(audit_sheet)
    end
  end

  private

  def add_supplier_details(shortlist_sheet)
    shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email']

    @supplier_frameworks.each do |supplier_framework|
      shortlist_sheet.add_row(
        [
          supplier_framework.supplier_name,
          supplier_framework.contact_detail.telephone_number,
          supplier_framework.contact_detail.email
        ]
      )
    end
  end

  def add_jurisdiction(sheet)
    jurisdictions = { 'a' => 'England & Wales', 'b' => 'Scotland', 'c' => 'Northern Ireland' }
    sheet.add_row ['Jurisdiction', jurisdictions[@params['jurisdiction']]]
  end

  def add_services(sheet)
    services = Service.where(id: @params['service_numbers'].map { |service_number| "RM6240.#{@params['lot_number']}#{@params['jurisdiction']}.#{service_number}" }).order(:id).pluck(:name)
    sheet.add_row ['Services', services.join(', ')]
  end
end
