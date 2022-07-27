require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FTACalculatorContractEnd, type: :model do
  subject(:step) do
    described_class.new(
      contract_start_date_day: '1',
      contract_start_date_month: '1',
      contract_start_date_year: '2022',
      contract_end_date_day: contract_end_date_day,
      contract_end_date_month: contract_end_date_month,
      contract_end_date_year: contract_end_date_year
    )
  end

  let(:contract_end_date_day) { '1' }
  let(:contract_end_date_month) { '2' }
  let(:contract_end_date_year) { '2022' }

  describe 'validations' do
    context 'when no contract_end_date_day is provided' do
      let(:contract_end_date_day) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:contract_end_date].first).to eq 'Enter the contract end date, including the day, month and year'
      end
    end

    context 'when no contract_end_date_month is provided' do
      let(:contract_end_date_month) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:contract_end_date].first).to eq 'Enter the contract end date, including the day, month and year'
      end
    end

    context 'when no contract_end_date_year is provided' do
      let(:contract_end_date_year) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:contract_end_date].first).to eq 'Enter the contract end date, including the day, month and year'
      end
    end

    context 'when the date is not real' do
      let(:contract_end_date_month) { '13' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:contract_end_date].first).to eq 'Enter the contract end date, including the day, month and year'
      end
    end

    context 'when the date is before the start date' do
      let(:contract_end_date_year) { '2020' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:contract_end_date].first).to eq 'The date the contract ended must be after the date the worker’s current contract started'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::FTACalculatorSalary' do
      expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTACalculatorSalary
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:contract_start_date_day, :contract_start_date_month, :contract_start_date_year, :contract_end_date_day, :contract_end_date_month, :contract_end_date_year, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[contract_start_date_day contract_start_date_month contract_start_date_year contract_end_date_day contract_end_date_month contract_end_date_year]
    end
  end

  describe '.slug' do
    it 'returns fta-calculator-contract-end' do
      expect(step.slug).to eq 'fta-calculator-contract-end'
    end
  end

  describe '.template' do
    it 'returns journey/fta_calculator_contract_end' do
      expect(step.template).to eq 'journey/fta_calculator_contract_end'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
