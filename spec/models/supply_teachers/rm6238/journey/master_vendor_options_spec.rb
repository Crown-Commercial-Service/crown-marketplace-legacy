require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::MasterVendorOptions do
  subject(:step) { described_class.new(managed_service_provider: 'master_vendor', threshold_position: threshold_position) }

  let(:threshold_position) { 'above_threshold' }

  describe 'validations' do
    context 'when no option is provided' do
      let(:threshold_position) { nil }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:threshold_position].first).to eq 'Select an option'
      end
    end

    context 'when an option that is not in the list provided' do
      let(:threshold_position) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:threshold_position].first).to eq 'Select an option'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'when threshold_position is above_threshold' do
      let(:threshold_position) { 'above_threshold' }

      it 'returns Journey::MasterVendors' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::MasterVendors
      end
    end

    context 'when threshold_position is below_threshold' do
      let(:threshold_position) { 'below_threshold' }

      it 'returns Journey::MasterVendors' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::MasterVendors
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:threshold_position, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq [:threshold_position]
    end
  end

  describe '.slug' do
    it 'returns master-vendor-options' do
      expect(step.slug).to eq 'master-vendor-options'
    end
  end

  describe '.template' do
    it 'returns journey/master_vendor_options' do
      expect(step.template).to eq 'journey/master_vendor_options'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
