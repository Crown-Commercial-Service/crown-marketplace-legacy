require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Rate, type: :model do
  subject(:rate) { build(:supply_teachers_rm6238_rate) }

  let(:all_codes) { described_class.all.map(&:code) }

  it { is_expected.to be_valid }

  it 'only has unique codes' do
    expect(all_codes.uniq).to contain_exactly(*all_codes)
  end

  context 'when validating the lot number' do
    it 'is not valid if lot_number is blank' do
      rate.lot_number = nil
      expect(rate).not_to be_valid
    end

    it 'is not valid if lot_number is not in list of all lot numbers' do
      rate.lot_number = 'invalid-number'
      expect(rate).not_to be_valid
      expect(rate.errors[:lot_number]).to include('is not included in the list')
    end
  end

  context 'when considering the job type' do
    let(:tenure_type) { rate.tenure_type }
    let(:job_type) { rate.job_type }

    before { rate.assign_attributes(tenure_type: tenure_type, job_type: job_type) }

    context 'and the job_type is blank' do
      let(:job_type) { '' }

      it 'is not valid' do
        expect(rate).not_to be_valid
      end
    end

    context 'and the job_type is not in list of all job types' do
      let(:job_type) { 'invalid-job-type' }

      it 'is not valid and has the correct error' do
        expect(rate).not_to be_valid
        expect(rate.errors[:job_type]).to include('is not included in the list')
      end
    end

    context 'and the job_type is teacher' do
      let(:job_type) { 'teacher' }

      context 'and the tenure_type is daily' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is 6_weeks_plus' do
        let(:tenure_type) { '6_weeks_plus' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and the tenure_type is not in the list' do
        let(:tenure_type) { 'invalid-tenure-type' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is support' do
      let(:job_type) { 'support' }

      context 'and the tenure_type is daily' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is 6_weeks_plus' do
        let(:tenure_type) { '6_weeks_plus' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and the tenure_type is not in the list' do
        let(:tenure_type) { 'invalid-tenure-type' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is senior' do
      let(:job_type) { 'senior' }

      context 'and the tenure_type is daily' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is 6_weeks_plus' do
        let(:tenure_type) { '6_weeks_plus' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and the tenure_type is not in the list' do
        let(:tenure_type) { 'invalid-tenure-type' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is other' do
      let(:job_type) { 'other' }

      context 'and the tenure_type is daily' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is 6_weeks_plus' do
        let(:tenure_type) { '6_weeks_plus' }

        it 'is valid' do
          expect(rate).to be_valid
        end
      end

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is not in the list' do
        let(:tenure_type) { 'invalid-tenure-type' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is over_12_week' do
      let(:job_type) { 'over_12_week' }

      context 'and the tenure_type is daily' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is a percentage' do
          expect(rate.percentage?).to be true
        end
      end

      context 'and the tenure_type is 6_weeks_plus' do
        let(:tenure_type) { '6_weeks_plus' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and the tenure_type is not in the list' do
        let(:tenure_type) { 'invalid-tenure-type' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is nominated' do
      let(:job_type) { 'nominated' }

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is not blank' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is fixed_term' do
      let(:job_type) { 'fixed_term' }

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is a percentage' do
          expect(rate.percentage?).to be true
        end
      end

      context 'and the tenure_type is not blank' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).not_to be_valid
        end
      end
    end

    context 'and the job_type is agency_management' do
      let(:job_type) { 'agency_management' }

      context 'and the tenure_type is daily' do
        let(:tenure_type) { 'daily' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is 6_weeks_plus' do
        let(:tenure_type) { '6_weeks_plus' }

        it 'is valid' do
          expect(rate).to be_valid
        end

        it 'is not a percentage' do
          expect(rate.percentage?).to be false
        end
      end

      context 'and the tenure_type is blank' do
        let(:tenure_type) { '' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end

      context 'and the tenure_type is not in the list' do
        let(:tenure_type) { 'invalid-tenure-type' }

        it 'is not valid' do
          expect(rate).not_to be_valid
        end
      end
    end
  end

  context 'when validating the rate' do
    before { rate.assign_attributes(rate: rate_value) }

    context 'and it is nil' do
      let(:rate_value) { nil }

      it 'is not valid' do
        expect(rate).not_to be_valid
      end
    end

    context 'and it is blank' do
      let(:rate_value) { '' }

      it 'is not valid' do
        expect(rate).not_to be_valid
      end
    end

    context 'and it is a string' do
      let(:rate_value) { 'I am string' }

      it 'is not valid' do
        expect(rate).not_to be_valid
      end
    end

    context 'and it is a float' do
      let(:rate_value) { 12.5 }

      it 'is not valid' do
        expect(rate).not_to be_valid
      end
    end

    context 'and it is an integer' do
      let(:rate_value) { 45 }

      it 'is valid' do
        expect(rate).to be_valid
      end
    end
  end

  context 'when considering the value' do
    before { rate.assign_attributes(rate: rate_value) }

    context 'and the rate value is 3550' do
      let(:rate_value) { 3550 }

      it 'returns 35.5' do
        expect(rate.value).to eq 35.5
      end
    end

    context 'and the rate value is 1200' do
      let(:rate_value) { 1200 }

      it 'returns 12.0' do
        expect(rate.value).to eq 12.0
      end
    end
  end

  context 'when validating the uniqueness' do
    let(:new_rate) do
      build(
        :supply_teachers_rm6238_rate,
        supplier: supplier,
        job_type: job_type,
        lot_number: lot_number,
        tenure_type: tenure_type
      )
    end
    let(:supplier) { rate.supplier }
    let(:job_type) { rate.job_type }
    let(:lot_number) { rate.lot_number }
    let(:tenure_type) { rate.tenure_type }

    before { rate.update!(job_type: 'teacher', tenure_type: 'daily') }

    context 'when the supplier, job_type, lot_number and tenure_type are the same' do
      it 'is not valid' do
        expect(new_rate).not_to be_valid
      end
    end

    context 'when the supplier is different' do
      let(:supplier) { build(:supply_teachers_rm6238_supplier) }

      it 'is valid' do
        expect(new_rate).to be_valid
      end
    end

    context 'when the job_type is different' do
      let(:job_type) { 'support' }

      it 'is valid' do
        expect(new_rate).to be_valid
      end
    end

    context 'when the lot_number is different' do
      let(:lot_number) { '4' }

      it 'is valid' do
        expect(new_rate).to be_valid
      end
    end

    context 'when the tenure_type is different' do
      let(:tenure_type) { '6_weeks_plus' }

      it 'is valid' do
        expect(new_rate).to be_valid
      end
    end
  end
end
