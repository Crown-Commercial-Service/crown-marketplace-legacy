class LegalServices::RM3788::SupplierSpreadsheetCreator < LegalServices::SupplierSpreadsheetCreator
  private

  def add_audit_trail(audit_sheet)
    audit_sheet.add_row ['Central Government user?', @params['central_government']]
    audit_sheet.add_row ['Fees under £20 000 per matter?', 'yes'] if @params['central_government'] == 'yes'
    lot = LegalServices::RM3788::Lot.find_by(number: @params['lot'])
    audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.description}"] unless @params['central_government'] == 'yes'
    add_jurisdiction(audit_sheet) if @params['lot'] == '2'
    add_services(audit_sheet) if ['1', '2'].include? @params['lot']
    add_regions(audit_sheet) if @params['lot'] == '1'
  end

  def add_regions(sheet)
    regions = []
    @params['region_codes'].each do |region_code|
      region_name = if region_code == 'UK'
                      'Full national coverage'
                    else
                      Nuts1Region.find_by(code: region_code).name
                    end

      regions << region_name
    end
    sheet.add_row ['Regions', regions.join(', ')]
  end
end
