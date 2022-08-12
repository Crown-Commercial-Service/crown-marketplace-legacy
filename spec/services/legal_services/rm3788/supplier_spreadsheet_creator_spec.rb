require 'rails_helper'

RSpec.describe LegalServices::RM3788::SupplierSpreadsheetCreator do
  let(:supplier_details) do
    [
      { name: 'COLONY 6 CORP', email: 'sharla@colony.six.ltd.com', phone_number: '0203 234 5678' },
      { name: 'MACNA AGENCY', email: 'riki@sneaky.com', phone_number: '0204 345 6789' },
      { name: 'ALCAMOTH COMMERCIAL SERVICE', email: 'melia@alcamothcommercial.com', phone_number: '0204 567 8901' }
    ]
  end

  let(:suppliers) { LegalServices::RM3788::Supplier.all.order(:name) }
  let(:lot_number) { '1' }
  let(:services) { LegalServices::RM3788::Service.all.sample(5).sort_by(&:code) }
  let(:service_codes) { services.map(&:code) }
  let(:region_codes) { Nuts1Region.all.sample(5).map(&:code) }
  let(:params) { { 'region_codes' => region_codes, 'services' => service_codes, 'lot' => lot_number } }
  let(:spreadsheet_creator) { described_class.new(suppliers, params) }

  let(:work_book) do
    IO.write('/tmp/ls_supplier_spreadsheet.xlsx', spreadsheet_creator.build.to_stream.read, binmode: true)
    Roo::Excelx.new('/tmp/ls_supplier_spreadsheet.xlsx')
  end

  before do
    allow(LegalServices::RM3788::Supplier).to receive(:offering_services_in_regions)
      .with(lot_number, service_codes, nil, region_codes).and_return(suppliers)

    supplier_details.each do |supplier_detail|
      create(:legal_services_rm3788_supplier, **supplier_detail)
    end
  end

  describe '.build' do
    it 'returns an Axlsx::Package' do
      spreadsheet = spreadsheet_creator.build
      expect(spreadsheet.class).to eq(Axlsx::Package)
    end
  end

  context 'when considering the Supplier shortlist sheet' do
    let(:sheet) { work_book.sheet('Supplier shortlist') }

    # rubocop:disable RSpec/MultipleExpectations
    it 'has the correct rows' do
      expect(sheet.row(1)).to eq ['Supplier name', 'Phone number', 'Email']
      expect(sheet.row(2)).to eq ['ALCAMOTH COMMERCIAL SERVICE', '0204 567 8901', 'melia@alcamothcommercial.com']
      expect(sheet.row(3)).to eq ['COLONY 6 CORP', '0203 234 5678', 'sharla@colony.six.ltd.com']
      expect(sheet.row(4)).to eq ['MACNA AGENCY', '0204 345 6789', 'riki@sneaky.com']
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  context 'when considering the Shortlist audit sheet' do
    let(:sheet) { work_book.sheet('Shortlist audit') }

    it 'has the correct services' do
      expect(sheet.row(1)).to eq ['Central Government user?', nil]
      expect(sheet.row(2)).to eq ['Lot', '1 - Regional service provision']
      expect(sheet.row(3)).to eq ['Services', services.map(&:name).join(', ')]
    end
  end
end
