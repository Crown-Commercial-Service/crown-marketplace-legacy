require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseSpecialisms do
  subject(:step) { described_class.new(specialism:) }

  let(:specialism) { 'full_service' }

  describe 'validations' do
    context 'when no specialism is provided' do
      let(:specialism) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:specialism].first).to eq 'Select at least one legal service'
      end
    end

    context 'when specialism is not in the list' do
      let(:specialism) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:specialism].first).to eq 'Select at least one legal service'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::ChooseSpecialisms' do
      expect(step.next_step_class).to be LegalServices::RM6374::Journey::SelectLot
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:specialism, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[specialism]
    end
  end

  describe '.slug' do
    it 'returns choose-specialism' do
      expect(step.slug).to eq 'choose-specialisms'
    end
  end

  describe '.template' do
    it 'returns journey/choose_specialism' do
      expect(step.template).to eq 'journey/choose_specialisms'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
