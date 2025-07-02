class ManagementConsultancy::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def initialize(supplier_frameworks, params, framework_name)
    super(supplier_frameworks, params)
    @framework_name = framework_name
  end

  def build
    super do |shortlist_sheet, audit_sheet|
      shortlist_sheet.add_row ['Supplier name', 'Contact name', 'Phone number', 'Email']
      add_supplier_details(shortlist_sheet)

      lot = Lot.find(@params['lot_id'])
      audit_sheet.add_row ['Lot', "#{@framework_name}.#{lot.number} - #{lot.name}"]
      add_services(audit_sheet)
    end
  end

  private

  def add_supplier_details(sheet)
    @supplier_frameworks.each do |supplier_framework|
      sheet.add_row(
        [
          supplier_framework.supplier_name,
          supplier_framework.contact_detail.name,
          supplier_framework.contact_detail.telephone_number,
          supplier_framework.contact_detail.email
        ]
      )
    end
  end
end
