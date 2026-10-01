require 'rails_helper'

RSpec.describe LegalServices::RM6374::SupplierSpreadsheetCreator do
  let(:service_names) { ['First service', 'Second service'] }
  let(:lot_number) { '1' }
  let(:jurisdiction) { 'a' }
  let(:service_numbers) { [1, 2] }
  let(:call_off_mechanism) { nil }
  let(:professions) { nil }
  let(:params) do
    {
      'jurisdiction' => jurisdiction,
      'service_numbers' => service_numbers,
      'lot_number' => lot_number,
      'call_off_mechanism' => call_off_mechanism,
      'professions' => professions
    }
  end

  let(:position_rows) do
    [
      ['RM6374.1.1', 'partner'],
      ['RM6374.1.2', 'senior']
    ]
  end

  let(:positions_relation) do
    instance_double(ActiveRecord::Relation).tap do |relation|
      allow(relation).to receive(:order).with(:number).and_return(relation)
      allow(relation).to receive(:pluck).with(:id, :name).and_return(position_rows)
      allow(relation).to receive(:where).and_return(relation)
    end
  end

  let(:lot) do
    instance_double(Lot, id: 'RM6374.1', number: lot_number, name: 'Full service provision', positions: positions_relation)
  end

  let(:contact_details) do
    [
      { name: 'COLONY 4 CORP', email: 'ethel@colony.four.ltd.com', telephone_number: '0203 234 5678', prospectus_link: 'https://example.com/colony' },
      { name: 'MAKTHA AGENCY', email: 'juniper@flowers.com', telephone_number: '0204 345 6789', prospectus_link: 'https://example.com/maktha' }
    ]
  end

  let(:supplier_frameworks) do
    contact_details.map do |details|
      framework = instance_double(
        Supplier::Framework,
        supplier_name: details[:name],
        contact_detail: instance_double(
          Supplier::Framework::ContactDetail,
          telephone_number: details[:telephone_number],
          email: details[:email],
          additional_details: { "lot_#{lot_number}_prospectus_link" => details[:prospectus_link] }
        ),
        lots: instance_double(ActiveRecord::Relation)
      )

      allow(framework.lots).to receive(:find_by).with(lot_id: lot.id).and_return(nil)
      framework
    end
  end

  let(:service_relation) do
    instance_double(ActiveRecord::Relation).tap do |relation|
      allow(relation).to receive(:order).with(:id).and_return(relation)
      allow(relation).to receive(:pluck).with(:name).and_return(service_names)
    end
  end

  let(:spreadsheet_creator) { described_class.new(supplier_frameworks, params) }

  let(:work_book) do
    File.write('/tmp/ls_rm6374_supplier_spreadsheet.xlsx', spreadsheet_creator.build.to_stream.read, binmode: true)
    Roo::Excelx.new('/tmp/ls_rm6374_supplier_spreadsheet.xlsx')
  end

  before do
    allow(Lot).to receive(:find).with('RM6374.1').and_return(lot)
    allow(Service).to receive(:where).and_return(service_relation)
  end

  describe '.build' do
    it 'returns an Axlsx::Package' do
      spreadsheet = spreadsheet_creator.build
      expect(spreadsheet).to be_a(Axlsx::Package)
    end
  end

  context 'when building the results spreadsheet (without call off mechanism)' do
    let(:sheet) { work_book.sheet('Supplier shortlist') }

    it 'writes the header row' do
      expect(sheet.row(1).first(3)).to eq ['Supplier name', 'Phone number', 'Email']
    end

    it 'writes the supplier detail rows' do
      expect(sheet.row(2).first(4)).to eq ['COLONY 4 CORP', '0203 234 5678', 'ethel@colony.four.ltd.com', 'https://example.com/colony']
      expect(sheet.row(3).first(4)).to eq ['MAKTHA AGENCY', '0204 345 6789', 'juniper@flowers.com', 'https://example.com/maktha']
    end
  end

  context 'when building the audit sheet' do
    let(:sheet) { work_book.sheet('Shortlist audit') }

    it 'includes the lot, services, and jurisdiction information' do
      expect(sheet.row(1)).to eq ['Lot', '1 - Full service provision']
      expect(sheet.row(2)).to eq ['Services', service_names.join(', ')]
      expect(sheet.row(3)).to eq ['Jurisdiction', 'England & Wales']
    end
  end

  context 'when building the rates spreadsheet (with call off mechanism)' do
    let(:call_off_mechanism) { 'further_competition' }
    let(:sheet) { work_book.sheet('Supplier rates') }

    context 'when supplier has valid non-zero rates' do
      before do
        framework_lot = instance_double(
          Supplier::Framework::Lot,
          rates: [
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 100.00, 100.00),
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 150.00, 150.00)
          ]
        )

        supplier_frameworks.each do |supplier_framework|
          allow(supplier_framework.lots).to receive(:find_by).with(lot_id: lot.id).and_return(framework_lot)
        end
      end

      it 'writes header and formatted currency rates' do
        expect(sheet.row(1)[0..1]).to eq ['Supplier name', 'Prospectus']
        expect(sheet.row(2)[0..3]).to eq ['COLONY 4 CORP', 'https://example.com/colony', '£100.00', '£150.00']
      end
    end

    context 'when supplier has zero rates or missing rates' do
      before do
        framework_lot = instance_double(
          Supplier::Framework::Lot,
          rates: [
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 0.0, 0.0),
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 0, 0)
          ]
        )

        supplier_frameworks.each do |supplier_framework|
          allow(supplier_framework.lots).to receive(:find_by).with(lot_id: lot.id).and_return(framework_lot)
        end
      end

      it 'renders empty cells for zero or missing rates' do
        expect(sheet.row(2)[2..3]).to eq [nil, nil]
      end
    end

    context 'when framework_lot is nil for a supplier' do
      before do
        supplier_frameworks.each do |supplier_framework|
          allow(supplier_framework.lots).to receive(:find_by).with(lot_id: lot.id).and_return(nil)
        end
      end

      it 'handles missing lot record gracefully without crashing' do
        expect(sheet.row(2).compact).to be_empty
      end
    end
  end

  describe '#get_filtered_positions' do
    let(:call_off_mechanism) { 'further_competition' }

    context 'when professions parameter is present' do
      let(:professions) { ['partner'] }
      let(:filtered_rows) { [['RM6374.1.1', 'partner']] }

      before do
        allow(positions_relation).to receive(:where).with(name: ['partner']).and_return(positions_relation)
        allow(positions_relation).to receive(:pluck).with(:id, :name).and_return(filtered_rows)
      end

      it 'filters positions using ActiveRecord where query' do
        sheet = work_book.sheet('Supplier rates')
        expect(positions_relation).to have_received(:where).with(name: ['partner'])
        expect(sheet.row(1).compact.length).to eq(3)
      end
    end

    context 'when professions parameter is empty or nil' do
      let(:professions) { nil }

      it 'returns all positions without invoking where' do
        expect(positions_relation).not_to have_received(:where)
      end
    end
  end
end
