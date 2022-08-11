require 'rails_helper'

RSpec.describe LegalServices::RM6240::Journey::ChooseJurisdiction, type: :model do
  subject(:step) { described_class.new(jurisdiction: jurisdiction, lot: lot_number) }

  let(:jurisdiction) { 'a' }
  let(:lot_number) { '1' }

  describe 'validations' do
    context 'when no jurisdiction is provided' do
      let(:jurisdiction) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:jurisdiction].first).to eq 'Select the jurisdiction you need'
      end
    end

    context 'when jurisdiction is not in the list' do
      let(:jurisdiction) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:jurisdiction].first).to eq 'Select the jurisdiction you need'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    pending 'returns Journey::ChooseSuppliers' do
      expect(step.next_step_class).to be LegalServices::RM6240::Journey::ChooseSuppliers
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot, :jurisdiction, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot jurisdiction]
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
    pending 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.selected_lot' do
    let(:result) { step.selected_lot }

    context 'when the lot exists' do
      it 'returns the lot' do
        expect(result.number).to eq '1'
        expect(result.description).to eq 'Full service provision'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_number) { '4' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end
