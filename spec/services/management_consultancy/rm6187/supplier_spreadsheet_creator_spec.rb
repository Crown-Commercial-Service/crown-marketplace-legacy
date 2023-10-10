require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::SupplierSpreadsheetCreator do
  let(:supplier_details) do
    [
      { name: 'MONADO LTD', contact_name: 'Shulk', contact_email: 'shulk@monado.com', telephone_number: '0202 123 4567' },
      { name: 'COLONY 9 LTD', contact_name: 'Fiora', contact_email: 'fiora@colony.nine.ltd.com', telephone_number: '0203 234 5678' },
      { name: 'COLONY 9 CORP', contact_name: 'Reyn', contact_email: 'reyn@colony.nine.corp.com', telephone_number: '0204 345 6789' },
      { name: 'BIONIS LTD', contact_name: 'Dunban', contact_email: 'dunban@bionis.com', telephone_number: '0204 567 8901' }
    ]
  end

  let(:suppliers) { ManagementConsultancy::RM6187::Supplier.order(:name) }
  let(:lot_number) { 'MCF3.1' }
  let(:lot) { ManagementConsultancy::RM6187::Lot.find_by(number: lot_number) }
  let(:services) { ManagementConsultancy::RM6187::Service.all.sample(5).sort_by(&:code) }
  let(:service_codes) { services.map(&:code) }
  let(:params) { { 'services' => service_codes, 'lot' => lot_number } }
  let(:spreadsheet_creator) { described_class.new(suppliers, params) }

  let(:work_book) do
    File.write('/tmp/mc_supplier_spreadsheet.xlsx', spreadsheet_creator.build.to_stream.read, binmode: true)
    Roo::Excelx.new('/tmp/mc_supplier_spreadsheet.xlsx')
  end

  before do
    supplier_details.each do |supplier_detail|
      create(:management_consultancy_rm6187_supplier, **supplier_detail)
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
      expect(sheet.row(1)).to eq ['Supplier name', 'Contact name', 'Phone number', 'Email']
      expect(sheet.row(2)).to eq ['BIONIS LTD', 'Dunban', '0204 567 8901', 'dunban@bionis.com']
      expect(sheet.row(3)).to eq ['COLONY 9 CORP', 'Reyn', '0204 345 6789', 'reyn@colony.nine.corp.com']
      expect(sheet.row(4)).to eq ['COLONY 9 LTD', 'Fiora', '0203 234 5678', 'fiora@colony.nine.ltd.com']
      expect(sheet.row(5)).to eq ['MONADO LTD', 'Shulk', '0202 123 4567', 'shulk@monado.com']
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  context 'when considering the Shortlist audit sheet' do
    let(:sheet) { work_book.sheet('Shortlist audit') }

    it 'has the correct services' do
      expect(sheet.row(1)).to eq ['Lot', 'MCF3.1 - Business']
      expect(sheet.row(2)).to eq ['Services', services.map(&:name).join(', ')]
    end
  end
end
