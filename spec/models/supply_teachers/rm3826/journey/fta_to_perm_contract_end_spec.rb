require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::Journey::FTAToPermContractEnd, type: :model do
  subject(:step) do
    described_class.new(
      contract_start_date_day: contract_start_date_day,
      contract_start_date_month: contract_start_date_month,
      contract_start_date_year: contract_start_date_year,
      contract_end_date_day: contract_end_date_day,
      contract_end_date_month: contract_end_date_month,
      contract_end_date_year: contract_end_date_year
    )
  end

  let(:contract_start_date_day) { contract_start_date.day }
  let(:contract_start_date_month) { contract_start_date.month }
  let(:contract_start_date_year) { contract_start_date.year }
  let(:contract_end_date_day) { contract_end_date.day }
  let(:contract_end_date_month) { contract_end_date.month }
  let(:contract_end_date_year) { contract_end_date.year }
  let(:contract_start_date) { Time.zone.today }
  let(:contract_end_date) { contract_start_date + 1.month }

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
    context 'when the contract end date is within six months' do
      context 'when the contract length is less than 12 months' do
        let(:contract_start_date) { Time.zone.today }
        let(:contract_end_date) { Time.zone.today + 1.month }

        it 'returns Journey::FTAToPermHireDate' do
          expect(step.next_step_class).to be SupplyTeachers::RM3826::Journey::FTAToPermHireDate
        end
      end

      context 'when the contract length is more than 12 months' do
        let(:contract_start_date) { Time.zone.today - 1.year }
        let(:contract_end_date) { Time.zone.today + 1.month }

        it 'returns Journey::FTAToPermFee' do
          expect(step.next_step_class).to be SupplyTeachers::RM3826::Journey::FTAToPermFee
        end

        it 'returns length_not_within_12_months for the next step class' do
          step.next_step_class

          expect(step.no_fee_reason).to eq 'length_not_within_12_months'
        end
      end
    end

    context 'when the contract end date is not within six months' do
      context 'when the contract length is less than 12 months' do
        let(:contract_start_date) { Time.zone.today }
        let(:contract_end_date) { contract_start_date + 7.months }

        it 'returns Journey::FTAToPermFee' do
          expect(step.next_step_class).to be SupplyTeachers::RM3826::Journey::FTAToPermFee
        end

        it 'returns end_not_within_6_months for the next step class' do
          step.next_step_class

          expect(step.no_fee_reason).to eq 'end_not_within_6_months'
        end
      end

      context 'when the contract length is more than 12 months' do
        let(:contract_start_date) { Time.zone.today }
        let(:contract_end_date) { contract_start_date + 13.months }

        it 'returns Journey::FTAToPermFee' do
          expect(step.next_step_class).to be SupplyTeachers::RM3826::Journey::FTAToPermFee
        end

        it 'returns end_not_within_6_months for the next step class' do
          step.next_step_class

          expect(step.no_fee_reason).to eq 'end_not_within_6_months'
        end
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:contract_start_date_day, :contract_start_date_month, :contract_start_date_year, :contract_end_date_day, :contract_end_date_month, :contract_end_date_year, :no_fee_reason, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[contract_start_date_day contract_start_date_month contract_start_date_year contract_end_date_day contract_end_date_month contract_end_date_year no_fee_reason]
    end
  end

  describe '.slug' do
    it 'returns fta-to-perm-contract-end' do
      expect(step.slug).to eq 'fta-to-perm-contract-end'
    end
  end

  describe '.template' do
    it 'returns journey/fta_to_perm_contract_end' do
      expect(step.template).to eq 'journey/fta_to_perm_contract_end'
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
