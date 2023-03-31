require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FTAToPermHireDate do
  subject(:step) do
    described_class.new(
      contract_end_date_day:,
      contract_end_date_month:,
      contract_end_date_year:,
      hire_date_day:,
      hire_date_month:,
      hire_date_year:
    )
  end

  let(:contract_end_date_day) { contract_end_date.day }
  let(:contract_end_date_month) { contract_end_date.month }
  let(:contract_end_date_year) { contract_end_date.year }
  let(:hire_date_day) { hire_date.day }
  let(:hire_date_month) { hire_date.month }
  let(:hire_date_year) { hire_date.year }
  let(:contract_end_date) { Time.zone.today }
  let(:hire_date) { contract_end_date + 1.month }

  describe 'validations' do
    context 'when no hire_date_day is provided' do
      let(:hire_date_day) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:hire_date].first).to eq 'Enter the date, including the day, month and year'
      end
    end

    context 'when no hire_date_month is provided' do
      let(:hire_date_month) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:hire_date].first).to eq 'Enter the date, including the day, month and year'
      end
    end

    context 'when no hire_date_year is provided' do
      let(:hire_date_year) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:hire_date].first).to eq 'Enter the date, including the day, month and year'
      end
    end

    context 'when the date is not real' do
      let(:hire_date_month) { '13' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:hire_date].first).to eq 'Enter the date, including the day, month and year'
      end
    end

    context 'when the hire date is before the end date' do
      let(:hire_date_year) { '2020' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:hire_date].first).to eq 'The date that you wish to hire the worker must be after the date the fixed term contract ended'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'when the contract hire date is within six months' do
      context 'when the contract length is less than 12 months' do
        let(:contract_end_date) { Time.zone.today }
        let(:hire_date) { contract_end_date + 2.months }

        it 'returns Journey::FTAToPermHireDateNotice' do
          expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTAToPermHireDateNotice
        end
      end
    end

    context 'when the contract hire date is not within six months' do
      let(:contract_end_date) { Time.zone.today }
      let(:hire_date) { contract_end_date + 7.months }

      it 'returns Journey::FTAToPermFee' do
        expect(step.next_step_class).to be SupplyTeachers::RM6238::Journey::FTAToPermFee
      end

      it 'returns hire_not_within_6_months for the next step class' do
        step.next_step_class

        expect(step.no_fee_reason).to eq 'hire_not_within_6_months'
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:contract_end_date_day, :contract_end_date_month, :contract_end_date_year, :hire_date_day, :hire_date_month, :hire_date_year, :no_fee_reason, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[contract_end_date_day contract_end_date_month contract_end_date_year hire_date_day hire_date_month hire_date_year no_fee_reason]
    end
  end

  describe '.slug' do
    it 'returns fta-to-perm-hire-date' do
      expect(step.slug).to eq 'fta-to-perm-hire-date'
    end
  end

  describe '.template' do
    it 'returns journey/fta_to_perm_hire_date' do
      expect(step.template).to eq 'journey/fta_to_perm_hire_date'
    end
  end

  describe '.all_keys_needed?' do
    it 'returns true' do
      expect(step.all_keys_needed?).to be true
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
