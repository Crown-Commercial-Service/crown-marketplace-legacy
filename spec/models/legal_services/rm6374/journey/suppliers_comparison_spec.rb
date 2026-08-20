require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::SuppliersComparison do
  subject(:comparison) { described_class.new(lot_number:, service_numbers:, professions:, jurisdiction:) }

  let(:lot_number) { '3' }
  let(:service_numbers) { %w[2 3] }
  let(:professions) { %w[partner solicitor] }
  let(:jurisdiction) { 'a' }

  describe 'JURISDICTION_MAP constant' do
    it 'contains all expected jurisdiction codes' do
      expect(described_class::JURISDICTION_MAP).to eq(
        'a' => 'RM6374.EW',
        'b' => 'RM6374.SC',
        'c' => 'RM6374.NI'
      )
    end
  end

  describe '#lot' do
    let(:lot) { instance_double(Lot, id: 'RM6374.3') }

    before do
      allow(Lot).to receive(:find).with('RM6374.3').and_return(lot)
    end

    it 'returns the lot for the configured lot number' do
      expect(comparison.lot).to eq(lot)
    end

    it 'memoizes the lot lookup' do
      expect(comparison.lot).to equal(comparison.lot)
    end
  end

  describe '#supplier_frameworks' do
    let(:lot) { instance_double(Lot, id: 'RM6374.3') }
    let(:supplier_frameworks_relation) { double('supplier_frameworks_relation') } # rubocop:disable RSpec/VerifiedDoubles
    let(:supplier_framework_1) { instance_double(Supplier::Framework, supplier_name: 'Zebra') }
    let(:supplier_framework_2) { instance_double(Supplier::Framework, supplier_name: 'Alpha') }
    let(:expected_services) { %w[RM6374.3.2 RM6374.3.3] }
    let(:expected_jurisdiction_ids) { %w[RM6374.EW] }

    before do
      allow(Lot).to receive(:find).with('RM6374.3').and_return(lot)
      allow(Supplier::Framework).to receive(:with_lots).with(lot.id).and_return(supplier_frameworks_relation)
      allow(supplier_frameworks_relation).to receive(:with_services_and_jurisdiction)
        .with(expected_services, expected_jurisdiction_ids)
        .and_return([supplier_framework_1, supplier_framework_2])
    end

    it 'queries supplier frameworks for the selected services and jurisdiction' do
      expect(comparison.supplier_frameworks).to eq([supplier_framework_2, supplier_framework_1])
      expect(Supplier::Framework).to have_received(:with_lots).with(lot.id)
      expect(supplier_frameworks_relation).to have_received(:with_services_and_jurisdiction)
        .with(expected_services, expected_jurisdiction_ids)
    end

    context 'when the jurisdiction is not mapped' do
      let(:jurisdiction) { 'RM6374.GB' }
      let(:expected_jurisdiction_ids) { ['RM6374.GB'] }

      it 'passes the jurisdiction through unchanged' do
        comparison.supplier_frameworks

        expect(supplier_frameworks_relation).to have_received(:with_services_and_jurisdiction)
          .with(expected_services, expected_jurisdiction_ids)
      end
    end

    context 'when the jurisdiction maps to Scotland' do
      let(:jurisdiction) { 'b' }
      let(:expected_jurisdiction_ids) { %w[RM6374.SC] }

      it 'translates the jurisdiction code using JURISDICTION_MAP' do
        comparison.supplier_frameworks

        expect(supplier_frameworks_relation).to have_received(:with_services_and_jurisdiction)
          .with(expected_services, expected_jurisdiction_ids)
      end
    end

    context 'when the jurisdiction maps to Northern Ireland' do
      let(:jurisdiction) { 'c' }
      let(:expected_jurisdiction_ids) { %w[RM6374.NI] }

      it 'translates code "c" to "RM6374.NI"' do
        comparison.supplier_frameworks

        expect(supplier_frameworks_relation).to have_received(:with_services_and_jurisdiction)
          .with(expected_services, expected_jurisdiction_ids)
      end
    end

    context 'when service_numbers is empty' do
      let(:service_numbers) { [] }
      let(:expected_services) { [] }

      it 'passes an empty array of expected services' do
        comparison.supplier_frameworks

        expect(supplier_frameworks_relation).to have_received(:with_services_and_jurisdiction)
          .with([], expected_jurisdiction_ids)
      end
    end

    it 'memoizes the supplier frameworks' do
      expect(comparison.supplier_frameworks).to equal(comparison.supplier_frameworks)
    end
  end

  describe '#supplier_frameworks_with_rates' do
    let(:lot) { instance_double(Lot, id: 'RM6374.3') }
    let(:supplier_framework) { instance_double(Supplier::Framework) }
    let(:rates) { { 'RM6374.3.4' => 'rate-a', 'RM6374.3.2' => 'rate-b' } }

    before do
      allow(comparison).to receive_messages(supplier_frameworks: [supplier_framework], lot: lot) # rubocop:disable RSpec/SubjectStub
      allow(supplier_framework).to receive(:grouped_rates_for_lot).with(lot.id).and_return(rates)
    end

    it 'returns each framework paired with its rates sorted by position id' do
      expect(comparison.supplier_frameworks_with_rates).to eq([
                                                                [supplier_framework, { 'RM6374.3.2' => 'rate-b', 'RM6374.3.4' => 'rate-a' }]
                                                              ])
    end

    context 'when grouped_rates_for_lot returns an empty hash' do
      let(:rates) { {} }

      it 'returns the supplier paired with an empty rates hash' do
        expect(comparison.supplier_frameworks_with_rates).to eq([[supplier_framework, {}]])
      end
    end

    context 'when rates keys are non-sequential or out of order' do
      let(:rates) do
        {
          'RM6374.3.9' => 'reviewer-rate',
          'RM6374.3.1' => 'partner-rate',
          'RM6374.3.5' => 'nq-rate'
        }
      end

      it 'sorts rates in strict ascending key order' do
        _supplier, sorted_rates = comparison.supplier_frameworks_with_rates.first

        expect(sorted_rates.keys).to eq(['RM6374.3.1', 'RM6374.3.5', 'RM6374.3.9'])
      end
    end

    it 'memoizes the result' do
      expect(comparison.supplier_frameworks_with_rates).to equal(comparison.supplier_frameworks_with_rates)
    end
  end

  describe '#positions' do
    let(:lot) { instance_double(Lot, id: "RM6374.#{lot_number}") }
    let(:positions_relation) { double('positions_relation') } # rubocop:disable RSpec/VerifiedDoubles

    let(:all_mocked_positions) do
      [
        ["RM6374.#{lot_number}.1", 'partner'],
        ["RM6374.#{lot_number}.2", 'legal_director'],
        ["RM6374.#{lot_number}.3", 'senior'],
        ["RM6374.#{lot_number}.4", 'solicitor'],
        ["RM6374.#{lot_number}.5", 'junior'],
        ["RM6374.#{lot_number}.6", 'trainee'],
        ["RM6374.#{lot_number}.7", 'paralegal'],
        ["RM6374.#{lot_number}.8", 'legal_project_manager'],
        ["RM6374.#{lot_number}.9", 'legal_document_reviewers']
      ]
    end

    before do
      allow(Lot).to receive(:find).with("RM6374.#{lot_number}").and_return(lot)
      allow(lot).to receive(:positions).and_return(positions_relation)

      ordered_positions = double('ordered_positions') # rubocop:disable RSpec/VerifiedDoubles
      allow(positions_relation).to receive(:order).with(:number).and_return(ordered_positions)
      allow(ordered_positions).to receive(:pluck).with(:id, :name).and_return(all_mocked_positions)
    end

    context 'when professions include partner and solicitor' do
      it 'returns only the matching position codes and names' do
        expect(comparison.positions).to eq(
          [
            ["RM6374.#{lot_number}.1", 'partner'],
            ["RM6374.#{lot_number}.4", 'solicitor']
          ]
        )
      end
    end

    context 'when professions are empty' do
      subject(:comparison) { described_class.new(lot_number:, service_numbers:, professions:, jurisdiction:) }

      let(:professions) { [] }

      it 'returns an empty array' do
        expect(comparison.positions).to eq(all_mocked_positions)
      end
    end

    context 'when professions include a non-matching value' do
      let(:professions) { %w[partner chef solicitor] }

      it 'filters out unsupported profession names' do
        expect(comparison.positions).to eq(
          [
            ["RM6374.#{lot_number}.1", 'partner'],
            ["RM6374.#{lot_number}.4", 'solicitor']
          ]
        )
      end
    end

    context 'when selecting all available professions' do
      let(:professions) { %w[all] }

      it 'returns all 9 positions formatted for the current lot_number' do
        expect(comparison.positions.count).to eq(9)
        expect(comparison.positions.map(&:first)).to eq([
                                                          'RM6374.3.1', 'RM6374.3.2', 'RM6374.3.3', 'RM6374.3.4',
                                                          'RM6374.3.5', 'RM6374.3.6', 'RM6374.3.7', 'RM6374.3.8', 'RM6374.3.9'
                                                        ])
      end
    end

    context 'when lot_number changes' do
      let(:lot_number) { '1' }
      let(:professions) { %w[partner] }

      it 'prefixes the position keys with the configured lot_number' do
        expect(comparison.positions).to eq([['RM6374.1.1', 'partner']])
      end
    end
  end
end
