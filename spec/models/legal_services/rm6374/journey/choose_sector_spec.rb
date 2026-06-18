require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseSector do
  subject(:step) { described_class.new(sector:) }

  let(:sector) { 'health' }

  describe 'validations' do
    context 'when no sector is provided' do
      let(:sector) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:sector].first).to eq 'Select your customer sector'
      end
    end

    context 'when sector is not in the list' do
      let(:sector) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:sector].first).to eq 'Select your customer sector'
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
      expect(step.next_step_class).to be LegalServices::RM6374::Journey::ChooseSpecialisms
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:sector, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[sector]
    end
  end

  describe '.slug' do
    it 'returns choose-sector' do
      expect(step.slug).to eq 'choose-sector'
    end
  end

  describe '.template' do
    it 'returns journey/choose_sector' do
      expect(step.template).to eq 'journey/choose_sector'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
