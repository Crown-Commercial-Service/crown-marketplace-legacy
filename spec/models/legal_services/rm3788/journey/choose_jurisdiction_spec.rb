require 'rails_helper'

RSpec.describe LegalServices::RM3788::Journey::ChooseJurisdiction, type: :model do
  subject(:step) { described_class.new(jurisdiction: jurisdiction) }

  let(:jurisdiction) { 'a' }

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
    it 'returns Journey::ChooseServices' do
      expect(step.next_step_class).to be LegalServices::RM3788::Journey::ChooseServices
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:jurisdiction, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[jurisdiction]
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
end
