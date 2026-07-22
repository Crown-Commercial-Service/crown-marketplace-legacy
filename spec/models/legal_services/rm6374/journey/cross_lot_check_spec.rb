# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::CrossLotCheck do
  describe '.get_service_numbers' do
    it 'returns sorted and distinct service numbers for the requested sub-lot from the database' do # rubocop:disable RSpec/MultipleExpectations
      result = described_class.get_service_numbers('1a')

      expect(result).to be_an(Array)
      expect(result).not_to be_empty
      expect(result.uniq).to eq(result)
      expect(result).to eq(result.sort_by(&:to_i))
    end

    it 'returns an empty array when no services match the lot number' do
      result = described_class.get_service_numbers('1d')
      expect(result).to eq([])
    end
  end

  describe '.evaluate' do
    before do
      # Mock lot 1 sublot services returned by .get_service_numbers
      allow(described_class).to receive(:get_service_numbers).with('1a').and_return(%w[1 2 3])
      allow(described_class).to receive(:get_service_numbers).with('1b').and_return(%w[2 3 4])
      allow(described_class).to receive(:get_service_numbers).with('1c').and_return(%w[5 6])
    end

    context 'when coming from Lot 1 (selected_sector is present)' do
      let(:selected_sector) { 'government_policy' } # Maps to lot_1a

      context 'when selected specialisms are available in other Lot 1 sublots and Lot 2 has suppliers' do
        before do
          # Specialisms 2 & 3 are present in both 1a and 1b
          allow(Supplier::Framework).to receive(:with_services)
            .with(['RM6374.2.2', 'RM6374.2.3'])
            .and_return([double('Supplier')]) # rubocop:disable RSpec/VerifiedDoubles
        end

        it 'recommends lot_1a and includes lot_1b and lot_2 as alternatives' do
          result = described_class.evaluate(
            selected_sector: selected_sector,
            selected_specialisms: %w[2 3]
          )

          expect(result[:recommended_lot]).to eq('lot_1a')
          expect(result[:alternatives]).to contain_exactly('lot_1b', 'lot_2')
        end
      end

      context 'when no other sublots or Lot 2 suppliers can satisfy the specialisms' do
        before do
          allow(Supplier::Framework).to receive(:with_services).and_return([])
        end

        it 'returns recommended lot_1a with no alternatives' do
          result = described_class.evaluate(
            selected_sector: selected_sector,
            selected_specialisms: %w[1 2 3] # Only lot_1a has all three
          )

          expect(result[:recommended_lot]).to eq('lot_1a')
          expect(result[:alternatives]).to be_empty
        end
      end
    end

    context 'when coming from Lot 2 (selected_sector is nil)' do
      let(:selected_sector) { nil }

      it 'recommends lot_2' do
        allow(Supplier::Framework).to receive(:with_services).and_return([])

        result = described_class.evaluate(
          selected_sector: nil,
          selected_specialisms: %w[1 2]
        )

        expect(result[:recommended_lot]).to eq('lot_2')
        expect(result[:alternatives]).to contain_exactly('lot_1a')
      end

      it 'does not add lot_2 to alternatives even if Lot 2 suppliers exist' do
        allow(Supplier::Framework).to receive(:with_services).and_return([double('Supplier')]) # rubocop:disable RSpec/VerifiedDoubles

        result = described_class.evaluate(
          selected_sector: nil,
          selected_specialisms: %w[1 2]
        )

        expect(result[:alternatives]).not_to include('lot_2')
      end

      it 'returns matching Lot 1 sublots as alternatives' do
        allow(Supplier::Framework).to receive(:with_services).and_return([])

        result = described_class.evaluate(
          selected_sector: nil,
          selected_specialisms: %w[2 3] # Fits lot_1a and lot_1b
        )

        expect(result[:recommended_lot]).to eq('lot_2')
        expect(result[:alternatives]).to contain_exactly('lot_1a', 'lot_1b')
      end
    end

    context 'sector mapping edge cases' do # rubocop:disable RSpec/ContextWording
      it 'correctly maps health to lot_1c' do
        allow(Supplier::Framework).to receive(:with_services).and_return([])

        result = described_class.evaluate(
          selected_sector: 'health',
          selected_specialisms: %w[5]
        )

        expect(result[:recommended_lot]).to eq('lot_1c')
      end

      it 'correctly maps local_community to lot_1b' do
        allow(Supplier::Framework).to receive(:with_services).and_return([])

        result = described_class.evaluate(
          selected_sector: 'local_community',
          selected_specialisms: %w[4]
        )

        expect(result[:recommended_lot]).to eq('lot_1b')
      end
    end
  end
end
