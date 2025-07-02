require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::SupplierSpreadsheetCreator do
  let(:supplier_details) do
    [
      { supplier_name: 'MONADO LTD', name: 'Shulk', email: 'shulk@monado.com', telephone_number: '0202 123 4567' },
      { supplier_name: 'COLONY 9 LTD', name: 'Fiora', email: 'fiora@colony.nine.ltd.com', telephone_number: '0203 234 5678' },
      { supplier_name: 'COLONY 9 CORP', name: 'Reyn', email: 'reyn@colony.nine.corp.com', telephone_number: '0204 345 6789' },
      { supplier_name: 'BIONIS LTD', name: 'Dunban', email: 'dunban@bionis.com', telephone_number: '0204 567 8901' }
    ]
  end

  let(:supplier_frameworks) { Supplier::Framework.joins(:supplier).order('supplier.name ASC') }
  let(:lot_id) { 'RM6187.1' }
  let(:services) { Service.where(lot_id:).sample(5).sort_by(&:id) }
  let(:service_ids) { services.map(&:id) }
  let(:central_government) { 'no' }
  let(:params) { { 'service_ids' => service_ids, 'lot_id' => lot_id } }
  let(:spreadsheet_creator) { described_class.new(supplier_frameworks, params) }

  let(:work_book) do
    File.write('/tmp/mc_supplier_spreadsheet.xlsx', spreadsheet_creator.build.to_stream.read, binmode: true)
    Roo::Excelx.new('/tmp/mc_supplier_spreadsheet.xlsx')
  end

  before do
    allow(Supplier::Framework).to receive(:with_services_in_jurisdiction).with(service_ids, 'GB').and_return(supplier_frameworks)

    supplier_details.each do |supplier_detail|
      supplier = create(:supplier, name: supplier_detail[:supplier_name])
      supplier_framework = create(:supplier_framework, supplier:)

      create(:supplier_framework_contact_detail, supplier_framework:, **supplier_detail.except(:supplier_name))
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
