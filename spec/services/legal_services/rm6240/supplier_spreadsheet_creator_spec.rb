require 'rails_helper'

RSpec.describe LegalServices::RM6240::SupplierSpreadsheetCreator do
  let(:supplier_details) do
    [
      { name: 'COLONY 4 CORP', email: 'ethel@colony.four.ltd.com 4 CORP', phone_number: '0203 234 5678' },
      { name: 'MAKTHA AGENCY', email: 'juniper@flowers.com', phone_number: '0204 345 6789' },
      { name: 'KEVIS CASTLE SERVICE', email: 'melia@kevis.castle.com', phone_number: '0204 567 8901' }
    ]
  end

  let(:suppliers) { LegalServices::RM6240::Supplier.order(:name) }
  let(:lot_number) { '1' }
  let(:jurisdiction) { 'a' }
  let(:services) { LegalServices::RM6240::Service.services_for_lot(lot_number).sample(5).sort_by(&:service_number) }
  let(:service_codes) { services.map(&:service_number) }
  let(:central_government) { 'no' }
  let(:params) { { 'central_government' => central_government, 'jurisdiction' => jurisdiction, 'services' => service_codes, 'lot' => lot_number } }
  let(:spreadsheet_creator) { described_class.new(suppliers, params) }

  let(:work_book) do
    File.write('/tmp/ls_supplier_spreadsheet.xlsx', spreadsheet_creator.build.to_stream.read, binmode: true)
    Roo::Excelx.new('/tmp/ls_supplier_spreadsheet.xlsx')
  end

  before do
    allow(LegalServices::RM6240::Supplier).to receive(:offering_services_in_jurisdiction)
      .with(lot_number, service_codes, jurisdiction).and_return(suppliers)

    supplier_details.each do |supplier_detail|
      create(:legal_services_rm6240_supplier, **supplier_detail)
    end
  end

  describe '.build' do
    it 'returns an Axlsx::Package' do
      spreadsheet = spreadsheet_creator.build
      expect(spreadsheet.class).to eq(Axlsx::Package)
    end
  end

  # rubocop:disable RSpec/MultipleExpectations
  context 'when considering the Supplier shortlist sheet' do
    let(:sheet) { work_book.sheet('Supplier shortlist') }

    it 'has the correct rows' do
      expect(sheet.row(1)).to eq ['Supplier name', 'Phone number', 'Email']
      expect(sheet.row(2)).to eq ['COLONY 4 CORP', '0203 234 5678', 'ethel@colony.four.ltd.com 4 CORP']
      expect(sheet.row(3)).to eq ['KEVIS CASTLE SERVICE', '0204 567 8901', 'melia@kevis.castle.com']
      expect(sheet.row(4)).to eq ['MAKTHA AGENCY', '0204 345 6789', 'juniper@flowers.com']
    end
  end

  context 'when considering the Shortlist audit sheet' do
    let(:sheet) { work_book.sheet('Shortlist audit') }

    context 'and the lot number is 1' do
      context 'and central govenment is no' do
        it 'has the correct data' do
          expect(sheet.row(1)).to eq ['Central Government user?', 'no']
          expect(sheet.row(2)).to eq ['Lot', '1 - Full service provision']
          expect(sheet.row(3)).to eq ['Services', services.map(&:name).join(', ')]
          expect(sheet.row(4)).to eq ['Jurisdiction', 'England & Wales']
        end
      end

      context 'and central govenment is yes' do
        let(:central_government) { 'yes' }

        it 'has the correct data' do
          expect(sheet.row(1)).to eq ['Central Government user?', 'yes']
          expect(sheet.row(2)).to eq ['Lot', '1 - Full service provision']
          expect(sheet.row(3)).to eq ['Services', services.map(&:name).join(', ')]
          expect(sheet.row(4)).to eq ['Jurisdiction', 'England & Wales']
        end
      end
    end

    context 'and the lot number is 2 and jurisdiction b' do
      let(:lot_number) { '2' }
      let(:jurisdiction) { 'b' }

      it 'has the correct data' do
        expect(sheet.row(1)).to eq ['Central Government user?', 'no']
        expect(sheet.row(2)).to eq ['Lot', '2 - General service provision']
        expect(sheet.row(3)).to eq ['Services', services.map(&:name).join(', ')]
        expect(sheet.row(4)).to eq ['Jurisdiction', 'Scotland']
      end
    end

    context 'and the lot number is 3' do
      let(:lot_number) { '3' }
      let(:jurisdiction) { nil }

      it 'has the correct data' do
        expect(sheet.row(1)).to eq ['Central Government user?', 'no']
        expect(sheet.row(2)).to eq ['Lot', '3 - Transport rail legal services']
        expect(sheet.row(3)).to eq [nil, nil]
      end
    end
  end
  # rubocop:enable RSpec/MultipleExpectations
end
