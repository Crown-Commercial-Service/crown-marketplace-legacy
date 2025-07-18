require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::SelectLot do
  subject(:step) { described_class.new(lot_id:) }

  let(:lot_id) { 'RM6360.1' }

  describe 'validations' do
    context 'when no lot_id is provided' do
      let(:lot_id) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:lot_id].first).to eq 'Select the lot you need'
      end
    end

    context 'when a lot number is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    [1, 2, 3, 5].each do |lot_number|
      context "and the lot_id is #{lot_number}" do
        let(:lot_id) { "RM6360.#{lot_number}" }

        it 'returns Journey::ChooseServices' do
          expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::ChooseServices
        end
      end
    end

    %w[4a 4b 4c].each do |lot_number|
      context "and the lot_id is #{lot_number}" do
        let(:lot_id) { "RM6360.#{lot_number}" }

        it 'returns Journey::CoreJurisdiction' do
          expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::CoreJurisdiction
        end
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id]
    end
  end

  describe '.slug' do
    it 'returns select-lot' do
      expect(step.slug).to eq 'select-lot'
    end
  end

  describe '.template' do
    it 'returns journey/select_lot' do
      expect(step.template).to eq 'journey/select_lot'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.lots' do
    let(:result) { described_class.lots }

    it 'returns the 3 lots sorted' do
      expect(result.pluck(:number)).to eq %w[1 2 3 4a 4b 4c 5]
    end
  end
end
