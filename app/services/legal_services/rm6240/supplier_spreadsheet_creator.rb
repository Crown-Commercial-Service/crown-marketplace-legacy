class LegalServices::RM6240::SupplierSpreadsheetCreator < LegalServices::SupplierSpreadsheetCreator
  private

  def add_audit_trail(audit_sheet)
    audit_sheet.add_row ['Central Government user?', @params['central_government'] || 'no']
    lot = Lot.find("RM6240.#{@params['lot_number']}#{@params['jurisdiction']}")
    audit_sheet.add_row ['Lot', "#{lot.number[0]} - #{lot.name}"]

    return if lot.id == 'RM6240.3'

    add_services(audit_sheet)
    add_jurisdiction(audit_sheet)
  end
end
