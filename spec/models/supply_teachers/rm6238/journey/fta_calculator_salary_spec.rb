require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FTACalculatorSalary do
  subject(:step) { described_class.new(salary:) }

  let(:salary) { '123456' }

  describe 'validations' do
    context 'when no salary is provided' do
      let(:salary) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:salary].first).to eq 'Enter the annual salary'
      end
    end

    context 'when the salary is not a number' do
      let(:salary) { 'salary' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:salary].first).to eq 'Enter a valid salary'
      end
    end

    context 'when the salary is 0' do
      let(:salary) { '0' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:salary].first).to eq 'Enter a valid salary'
      end
    end

    context 'when the salary is less than 0' do
      let(:salary) { '-123' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:salary].first).to eq 'Enter a valid salary'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::SchoolPostcodeAgencySuppliedWorker' do
      expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::SchoolPostcodeAgencySuppliedWorker
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:salary, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[salary]
    end
  end

  describe '.slug' do
    it 'returns fta-calculator-salary' do
      expect(step.slug).to eq 'fta-calculator-salary'
    end
  end

  describe '.template' do
    it 'returns journey/fta_calculator_salary' do
      expect(step.template).to eq 'journey/fta_calculator_salary'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
