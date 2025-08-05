require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::CoreJurisdiction do
  subject(:step) { described_class.new(not_core_jurisdiction:, lot_id:) }

  let(:not_core_jurisdiction) { 'no' }
  let(:lot_id) { 'RM6360.4b' }

  describe 'validations' do
    context 'when no options is picked' do
      let(:not_core_jurisdiction) { nil }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:not_core_jurisdiction].first).to eq 'Select if your requirement is for a country outside the listed locations'
      end
    end

    context 'when selected option is not in the list is not in the list' do
      let(:not_core_jurisdiction) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:not_core_jurisdiction].first).to eq 'Select if your requirement is for a country outside the listed locations'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'when yes is selected' do
      let(:not_core_jurisdiction) { 'yes' }

      it 'returns Journey::ChooseJurisdiction' do
        expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::ChooseJurisdiction
      end
    end

    context 'when no is selected' do
      it 'returns Journey::ChooseServices' do
        expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::ChooseServices
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, :not_core_jurisdiction, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id not_core_jurisdiction]
    end
  end

  describe '.slug' do
    it 'returns core-jurisdiction' do
      expect(step.slug).to eq 'core-jurisdiction'
    end
  end

  describe '.template' do
    it 'returns journey/core_jurisdiction' do
      expect(step.template).to eq 'journey/core_jurisdiction'
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
