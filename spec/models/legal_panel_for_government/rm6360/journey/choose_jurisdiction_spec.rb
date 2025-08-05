require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::ChooseJurisdiction do
  subject(:step) { described_class.new(jurisdiction_ids:, lot_id:) }

  let(:jurisdiction_ids) { %w[AD AE AX] }
  let(:lot_id) { 'RM6360.4b' }

  describe 'validations' do
    context 'when nothing is selected' do
      let(:jurisdiction_ids) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:jurisdiction_ids].first).to eq 'Select the countries for your requirement'
      end
    end

    context 'when an option is selected' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::ChooseServices' do
      expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::ChooseServices
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, { jurisdiction_ids: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id jurisdiction_ids]
    end
  end

  describe '.slug' do
    it 'returns choose-jurisdiction' do
      expect(step.slug).to eq 'choose-jurisdiction'
    end
  end

  describe '.template' do
    it 'returns journey/choose_jurisdiction' do
      expect(step.template).to eq 'journey/choose_jurisdiction'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.lot' do
    let(:result) { step.lot }

    context 'when the lot exists' do
      it 'returns the lot' do
        expect(result.id).to eq 'RM6360.4b'
        expect(result.name).to eq 'International Trade Disputes'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_id) { 'RM6360.6' }

      it 'returns nil' do
        expect { result }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
