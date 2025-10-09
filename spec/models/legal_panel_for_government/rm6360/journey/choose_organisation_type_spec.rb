require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::ChooseOrganisationType do
  subject(:step) { described_class.new(central_government:) }

  let(:central_government) { 'yes' }

  describe 'validations' do
    context 'when no central_government is provided' do
      let(:central_government) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:central_government].first).to eq 'Select yes if you work for central government or an arms length body'
      end
    end

    context 'when central_government is not in the list' do
      let(:central_government) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:central_government].first).to eq 'Select yes if you work for central government or an arms length body'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'and the central government is yes' do
      let(:central_government) { 'yes' }

      it 'returns Journey::InformationAboutYourRequirement' do
        expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::InformationAboutYourRequirement
      end
    end

    context 'and the central government is no' do
      let(:central_government) { 'no' }

      it 'returns Journey::Sorry' do
        expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::Sorry
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:central_government, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[central_government]
    end
  end

  describe '.slug' do
    it 'returns choose-organisation-type' do
      expect(step.slug).to eq 'choose-organisation-type'
    end
  end

  describe '.template' do
    it 'returns journey/choose_organisation_type' do
      expect(step.template).to eq 'journey/choose_organisation_type'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
