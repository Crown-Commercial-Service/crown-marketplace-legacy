class LegalServices::RM3788::SupplierSpreadsheetCreator < SupplierSpreadsheetCreator
  def initialize(suppliers, params)
    super(suppliers, params, LegalServices::RM3788::Service)
  end

  def build
    super do |shortlist_sheet, audit_sheet|
      shortlist_sheet.add_row ['Supplier name', 'Phone number', 'Email']
      add_supplier_details(shortlist_sheet)

      audit_sheet.add_row ['Central Government user?', @params['central_government']]
      audit_sheet.add_row ['Fees under £20 000 per matter?', 'yes'] if @params['central_government'] == 'yes'
      lot = LegalServices::RM3788::Lot.find_by(number: @params['lot'])
      audit_sheet.add_row ['Lot', "#{lot.number} - #{lot.description}"] unless @params['central_government'] == 'yes'
      add_audit_trail(audit_sheet)
    end
  end

  private

  def add_supplier_details(sheet)
    @suppliers.each do |supplier|
      sheet.add_row(
        [
          supplier.name,
          supplier.phone_number,
          supplier.email
        ]
      )
    end
  end

  def add_audit_trail(sheet)
    add_jurisdiction(sheet) if @params['lot'] == '2'
    add_services(sheet) if ['1', '2'].include? @params['lot']
    add_regions(sheet) if @params['lot'] == '1'
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

  def add_jurisdiction(sheet)
    jurisdictions = { 'a' => 'England & Wales', 'b' => 'Scotland', 'c' => 'Northern Ireland' }
    sheet.add_row ['Jurisdiction', jurisdictions[@params['jurisdiction']]]
  end
end
