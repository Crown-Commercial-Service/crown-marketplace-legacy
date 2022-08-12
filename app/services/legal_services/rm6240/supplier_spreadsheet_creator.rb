class LegalServices::RM6240::SupplierSpreadsheetCreator < LegalServices::SupplierSpreadsheetCreator
  private

  def add_audit_trail(audit_sheet)
    audit_sheet.add_row ['Central Government user?', @params['central_government'] || 'no']
    lot = LegalServices::RM6240::Lot.find_by(number: @params['lot'])
    audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.description}"]

    return if @params['lot'] == '3'

    add_services(audit_sheet)
    add_jurisdiction(audit_sheet)
  end

  def add_services(sheet)
    services = @params['services'].map { |service_code| @service_model.find_by(lot_number: @params['lot'], service_number: service_code).name }
    sheet.add_row ['Services', services.join(', ')]
  end
end
