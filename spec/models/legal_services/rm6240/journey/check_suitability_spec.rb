require 'rails_helper'

RSpec.describe LegalServices::RM6240::Journey::CheckSuitability do
  subject(:step) { described_class.new(service_suitable: service_suitable) }

  let(:service_suitable) { 'yes' }

  describe 'validations' do
    context 'when no service_suitable is provided' do
      let(:service_suitable) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:service_suitable].first).to eq 'Select yes if your requirements allow you to continue'
      end
    end

    context 'when service_suitable is not in the list' do
      let(:service_suitable) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:service_suitable].first).to eq 'Select yes if your requirements allow you to continue'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'and the service_suitable is yes' do
      let(:service_suitable) { 'yes' }

      it 'returns Journey::SelectLot' do
        expect(step.next_step_class).to be LegalServices::RM6240::Journey::SelectLot
      end
    end

    context 'and the service_suitable is no' do
      let(:service_suitable) { 'no' }

      it 'returns Journey::Sorry' do
        expect(step.next_step_class).to be LegalServices::RM6240::Journey::Sorry
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:service_suitable, :lot, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[service_suitable lot]
    end
  end

  describe '.slug' do
    it 'returns check-suitability' do
      expect(step.slug).to eq 'check-suitability'
    end
  end

  describe '.template' do
    it 'returns journey/check_suitability' do
      expect(step.template).to eq 'journey/check_suitability'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
