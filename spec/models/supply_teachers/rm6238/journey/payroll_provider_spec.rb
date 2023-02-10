require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::PayrollProvider do
  subject(:step) { described_class.new(payroll_provider: payroll_provider) }

  let(:payroll_provider) { 'agency' }

  describe 'validations' do
    context 'when no payroll_provider is provided' do
      let(:payroll_provider) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:payroll_provider].first).to eq 'Select yes if you want to put the worker on the school’s payroll'
      end
    end

    context 'when payroll_provider is not in the list' do
      let(:payroll_provider) { 'non-valid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:payroll_provider].first).to eq 'Select yes if you want to put the worker on the school’s payroll'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'and the payroll provider is agency' do
      let(:payroll_provider) { 'agency' }

      it 'returns Journey::AgencyPayroll' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::AgencyPayroll
      end
    end

    context 'and the payroll provider is school' do
      let(:payroll_provider) { 'school' }

      it 'returns Journey::FTACalculatorContractStart' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTACalculatorContractStart
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:payroll_provider, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[payroll_provider]
    end
  end

  describe '.slug' do
    it 'returns payroll-provider' do
      expect(step.slug).to eq 'payroll-provider'
    end
  end

  describe '.template' do
    it 'returns journey/payroll_provider' do
      expect(step.template).to eq 'journey/payroll_provider'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
