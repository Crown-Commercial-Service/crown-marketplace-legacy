require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::ManagedServiceProvider, type: :model do
  subject(:step) { described_class.new(managed_service_provider: managed_service_provider) }

  let(:managed_service_provider) { 'master_vendor' }

  describe 'validations' do
    context 'when no option is provided' do
      let(:managed_service_provider) { nil }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:managed_service_provider].first).to eq 'Select master vendor or education technology platform service'
      end
    end

    context 'when an option that is not in the list provided' do
      let(:managed_service_provider) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:managed_service_provider].first).to eq 'Select master vendor or education technology platform service'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'when managed_service_provider is master_vendor' do
      let(:managed_service_provider) { 'master_vendor' }

      it 'returns Journey::MasterVendorOptions' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::MasterVendorOptions
      end
    end

    context 'when managed_service_provider is education_technology_platform' do
      let(:managed_service_provider) { 'education_technology_platform' }

      it 'returns Journey::EducationTechnologyPlatformVendors' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::EducationTechnologyPlatformVendors
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:managed_service_provider, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq [:managed_service_provider]
    end
  end

  describe '.slug' do
    it 'returns managed-service-provider' do
      expect(step.slug).to eq 'managed-service-provider'
    end
  end

  describe '.template' do
    it 'returns journey/managed_service_provider' do
      expect(step.template).to eq 'journey/managed_service_provider'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
