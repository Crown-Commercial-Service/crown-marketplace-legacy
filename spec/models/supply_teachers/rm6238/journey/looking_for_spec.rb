require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::LookingFor do
  subject(:step) { described_class.new(looking_for: looking_for) }

  let(:looking_for) { 'worker' }

  describe 'validations' do
    context 'when no option is provided' do
      let(:looking_for) { nil }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:looking_for].first).to eq 'Select individual worker, managed service provider, or calculate temp-to-perm fee'
      end
    end

    context 'when an option that is not in the list provided' do
      let(:looking_for) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:looking_for].first).to eq 'Select individual worker, managed service provider, or calculate temp-to-perm fee'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'when looking for is worker' do
      let(:looking_for) { 'worker' }

      it 'returns Journey::WorkerType' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::WorkerType
      end
    end

    context 'when looking for is master_vendor' do
      let(:looking_for) { 'master_vendor' }

      it 'returns Journey::MasterVendorOptions' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::MasterVendorOptions
      end
    end

    context 'when looking for is education_technology_platform' do
      let(:looking_for) { 'education_technology_platform' }

      it 'returns Journey::EducationTechnologyPlatformVendors' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::EducationTechnologyPlatformVendors
      end
    end

    context 'when looking for is calculate_temp_to_perm_fee' do
      let(:looking_for) { 'calculate_temp_to_perm_fee' }

      it 'returns Journey::TempToPermCalculator' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::TempToPermCalculator
      end
    end

    context 'when looking for is calculate_fta_to_perm_fee' do
      let(:looking_for) { 'calculate_fta_to_perm_fee' }

      it 'returns Journey::FTAToPermContractStart' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTAToPermContractStart
      end
    end

    context 'when looking for is all_suppliers' do
      let(:looking_for) { 'all_suppliers' }

      it 'returns Journey::AllSuppliers' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::AllSuppliers
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:looking_for, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq [:looking_for]
    end
  end

  describe '.slug' do
    it 'returns looking-for' do
      expect(step.slug).to eq 'looking-for'
    end
  end

  describe '.template' do
    it 'returns journey/looking_for' do
      expect(step.template).to eq 'journey/looking_for'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
