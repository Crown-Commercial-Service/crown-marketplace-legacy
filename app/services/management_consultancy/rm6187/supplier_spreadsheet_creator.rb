class ManagementConsultancy::RM6187::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def initialize(suppliers, params)
    super(suppliers, params, ManagementConsultancy::RM6187::Service)
  end

  def build
    super do |shortlist_sheet, audit_sheet|
      shortlist_sheet.add_row ['Supplier name', 'Contact name', 'Phone number', 'Email']
      add_supplier_details(shortlist_sheet)

      lot = ManagementConsultancy::RM6187::Lot.find_by(number: @params['lot'])
      audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.description}"]
      add_services(audit_sheet)
    end
  end

  private

  def add_supplier_details(sheet)
    @suppliers.each do |supplier|
      rate_card = supplier.rate_cards.where(lot: @params['lot']).first
      sheet.add_row(
        [
          supplier.name,
          rate_card.contact_name,
          supplier.telephone_number,
          supplier.contact_email
        ]
      )
    end
  end
end
