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

    context 'when the lot is Lot 2' do
      let(:lot_number) { '2' }
      let(:lot) do
        instance_double(
          Lot,
          id: 'RM6374.2',
          number: '2',
          name: 'Focused Legal Support',
          positions: positions_relation
        )
      end

      let(:service_records) do
        [
          ['RM6374.2.1', 'Artificial Intelligence and Machine Learning Law'],
          ['RM6374.2.2', 'Assimilated Law']
        ]
      end

      let(:service_relation) do
        instance_double(ActiveRecord::Relation).tap do |relation|
          allow(relation).to receive(:order).with(:id).and_return(relation)
          allow(relation).to receive(:pluck).with(:name).and_return(service_records.map(&:last))
          allow(relation).to receive(:pluck).with(:id, :name).and_return(service_records)
        end
      end

      let(:framework_lot_1) { instance_double(Supplier::Framework::Lot) }
      let(:framework_lot_2) { instance_double(Supplier::Framework::Lot) }
      let(:rates_relation_1) { double('rates_relation_1') } # rubocop:disable RSpec/VerifiedDoubles
      let(:rates_relation_2) { double('rates_relation_2') } # rubocop:disable RSpec/VerifiedDoubles

      before do
        allow(Lot).to receive(:find).with('RM6374.2').and_return(lot)
        allow(supplier_frameworks[0].lots).to receive(:find_by).with(lot_id: 'RM6374.2').and_return(framework_lot_1)
        allow(supplier_frameworks[1].lots).to receive(:find_by).with(lot_id: 'RM6374.2').and_return(framework_lot_2)

        allow(framework_lot_1).to receive(:rates).and_return(rates_relation_1)
        allow(framework_lot_2).to receive(:rates).and_return(rates_relation_2)
      end

      context 'when single_or_multiple_suppliers is single' do
        let(:params) { super().merge('single_or_multiple_suppliers' => 'single') }

        let(:rates_service_1) do
          [
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 200.0, 200.0),
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 150.0, 150.0)
          ]
        end

        let(:rates_service_2) do
          [
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 250.0, 250.0),
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 180.0, 180.0)
          ]
        end

        before do
          allow(rates_relation_1).to receive(:where).with(service_id: 'RM6374.2.1').and_return(rates_service_1)
          allow(rates_relation_1).to receive(:where).with(service_id: 'RM6374.2.2').and_return(rates_service_2)
          allow(rates_relation_2).to receive(:where).with(service_id: 'RM6374.2.1').and_return([])
          allow(rates_relation_2).to receive(:where).with(service_id: 'RM6374.2.2').and_return([])
        end

        it 'renders the supplier row, updated headers starting with Selected service, and service rate rows' do # rubocop:disable RSpec/MultipleExpectations
          expect(sheet.row(1).first(2)).to eq(['COLONY 4 CORP', 'https://example.com/colony'])
          expect(sheet.row(2).first(3)).to eq(['Selected service', 'Prospectus', 'Partner'])
          expect(sheet.row(3).first(3)).to eq(['Artificial Intelligence and Machine Learning Law', '£200.00', '£150.00'])
          expect(sheet.row(4).first(3)).to eq(['Assimilated Law', '£250.00', '£180.00'])
        end
      end

      context 'when single_or_multiple_suppliers is multiple' do
        let(:params) { super().merge('single_or_multiple_suppliers' => 'multiple') }

        context 'when suppliers have rates for the services' do # rubocop:disable RSpec/NestedGroups
          let(:rates_s1_f1) do
            [
              Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 300.0, 300.0),
              Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 200.0, 200.0)
            ]
          end

          let(:rates_s1_f2) do
            [
              Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 280.0, 280.0),
              Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 190.0, 190.0)
            ]
          end

          before do
            allow(rates_relation_1).to receive(:where).with(service_id: 'RM6374.2.1').and_return(rates_s1_f1)
            allow(rates_relation_1).to receive(:where).with(service_id: 'RM6374.2.2').and_return([])

            allow(rates_relation_2).to receive(:where).with(service_id: 'RM6374.2.1').and_return(rates_s1_f2)
            allow(rates_relation_2).to receive(:where).with(service_id: 'RM6374.2.2').and_return([])
          end

          it 'groups by service, shows headers, and sorts suppliers alphabetically' do # rubocop:disable RSpec/MultipleExpectations
            expect(sheet.row(1).first(1)).to eq(['Artificial Intelligence and Machine Learning Law'])
            expect(sheet.row(2).first(3)).to eq(['Supplier name', 'Prospectus', 'Partner'])
            expect(sheet.row(3).first(4)).to eq(['COLONY 4 CORP', 'https://example.com/colony', '£300.00', '£200.00'])
            expect(sheet.row(4).first(4)).to eq(['MAKTHA AGENCY', 'https://example.com/maktha', '£280.00', '£190.00'])
          end

          it 'shows fallback message and omits position header when no suppliers have rates' do
            # Row 5 is empty separator row between services
            expect(sheet.row(6).first(1)).to eq(['Assimilated Law'])
            expect(sheet.row(7).first(1)).to eq(['Contact GCA legal services category team at info@gca.gov.uk to discuss your needs.'])
            expect(sheet.row(7)).not_to include('Supplier name')
          end
        end

        context 'when a supplier has no rates for a service' do # rubocop:disable RSpec/NestedGroups
          let(:rates_s1_f1) do
            [
              Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 300.0, 300.0),
              Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 200.0, 200.0)
            ]
          end

          before do
            allow(rates_relation_1).to receive(:where).with(service_id: 'RM6374.2.1').and_return(rates_s1_f1)
            allow(rates_relation_1).to receive(:where).with(service_id: 'RM6374.2.2').and_return([])

            # Supplier 2 has zero/blank rates
            allow(rates_relation_2).to receive(:where).with(service_id: 'RM6374.2.1').and_return([])
            allow(rates_relation_2).to receive(:where).with(service_id: 'RM6374.2.2').and_return([])
          end

          it 'excludes the supplier with no rates from that service section' do # rubocop:disable RSpec/MultipleExpectations
            # Service 1 only lists COLONY 4 CORP; MAKTHA AGENCY is omitted
            expect(sheet.row(1).first(1)).to eq(['Artificial Intelligence and Machine Learning Law'])
            expect(sheet.row(2).first(2)).to eq(['Supplier name', 'Prospectus'])
            expect(sheet.row(3).first(1)).to eq(['COLONY 4 CORP'])
            expect(sheet.row(4).compact).to be_empty
          end
        end
      end
    end

    describe '#selected_supplier_frameworks' do
      let(:call_off_mechanism) { 'further_competition' }

      before do
        allow(supplier_frameworks[0]).to receive(:id).and_return('sf-id-1')
        allow(supplier_frameworks[1]).to receive(:id).and_return('sf-id-2')

        framework_lot = instance_double(
          Supplier::Framework::Lot,
          rates: [
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.1', 100.00, 100.00),
            Struct.new(:position_id, :rate, :normalized_rate).new('RM6374.1.2', 150.00, 150.00)
          ]
        )

        supplier_frameworks.each do |sf|
          allow(sf.lots).to receive(:find_by).with(lot_id: lot.id).and_return(framework_lot)
        end
      end

      context 'when supplier_framework_ids parameter is present' do
        let(:params) { super().merge('supplier_framework_ids' => ['sf-id-2']) }

        it 'only exports rates for the selected supplier frameworks' do
          expect(sheet.row(2).first(1)).to eq(['MAKTHA AGENCY'])
          expect(sheet.row(3).compact).to be_empty
        end
      end

      context 'when supplier_framework_ids parameter is empty or blank' do
        let(:params) { super().merge('supplier_framework_ids' => ['']) }

        it 'exports all supplier frameworks' do
          expect(sheet.row(2).first(1)).to eq(['COLONY 4 CORP'])
          expect(sheet.row(3).first(1)).to eq(['MAKTHA AGENCY'])
        end
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
