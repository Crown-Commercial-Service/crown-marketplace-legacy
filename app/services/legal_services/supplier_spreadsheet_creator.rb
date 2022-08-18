class LegalServices::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def initialize(suppliers, params)
    super(suppliers, params, self.class.module_parent::Service)
  end

  def build
    super do |shortlist_sheet, audit_sheet|
      add_supplier_details(shortlist_sheet)
      add_audit_trail(audit_sheet)
    end
  end

  private

  def add_supplier_details(shortlist_sheet)
    shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email']

    @suppliers.each do |supplier|
      shortlist_sheet.add_row(
        [
          supplier.name,
          supplier.phone_number,
          supplier.email
        ]
      )
    end
  end

  def add_jurisdiction(sheet)
    jurisdictions = { 'a' => 'England & Wales', 'b' => 'Scotland', 'c' => 'Northern Ireland' }
    sheet.add_row ['Jurisdiction', jurisdictions[@params['jurisdiction']]]
  end
end
