require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::TempToPermCalculator::Calculator, type: :calculator do
  subject(:calculator) do
    described_class.new(
      contract_start_date:,
      days_per_week:,
      daily_fee:,
      hire_date:,
      notice_date:,
      holiday_1_start_date:,
      holiday_1_end_date:,
      holiday_2_start_date:,
      holiday_2_end_date:
    )
  end

  include_context 'with friendly dates RM6238'

  stub_bank_holiday_json

  let(:contract_start_date) { start_of_1st_week }
  let(:daily_fee) { 10 }
  let(:hire_date) { start_of_1st_week }
  let(:notice_date) { nil }
  let(:holiday_1_start_date) { nil }
  let(:holiday_1_end_date) { nil }
  let(:holiday_2_start_date) { nil }
  let(:holiday_2_end_date) { nil }
  let(:days_per_week) { 5 }

  describe 'initialization' do
    context 'when hire date is earlier than contract start date' do
      let(:hire_date) { 1.week.before(contract_start_date) }

      it 'raises an ArgumentError' do
        expect { calculator }.to raise_error(ArgumentError)
      end
    end

    context 'when notice date is later than hire date' do
      let(:notice_date) { 1.week.after(hire_date) }

      it 'raises an ArgumentError' do
        expect { calculator }.to raise_error(ArgumentError)
      end
    end

    context 'when notice date is earlier than contract start date' do
      let(:notice_date) { 1.week.before(contract_start_date) }

      it 'raises an ArgumentError' do
        expect { calculator }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'irrespective of the hire date' do
    it 'calculates the daily supplier fee based on daily fee' do
      expect(calculator.daily_supplier_fee).to be_within(1e-6).of(10)
    end

    it 'calculates the ideal hire date as the start of the 13th week to avoid paying an early hire fee' do
      expect(calculator.ideal_hire_date).to eq(start_of_13th_week)
    end

    it 'calculates the ideal notice date as the start of the 9th week to avoid paying a lack of notice fee' do
      expect(calculator.ideal_notice_date).to eq(start_of_9th_week)
    end

    it 'returns the number of days notice required' do
      expect(calculator.days_notice_required).to eq(
        described_class::WORKING_DAYS_NOTICE_PERIOD_REQUIRED_TO_AVOID_LATE_NOTICE_FEE
      )
    end

    it 'calculates the maximum fee for lack of notice as 20 days of the daily supplier fee' do
      expect(calculator.maximum_fee_for_lack_of_notice).to be_within(1e-6).of(20 * 10)
    end

    context 'when daily fee is 16' do
      let(:daily_fee) { 16 }

      it 'calculates the maximum fee for lack of notice as 20 days of the daily supplier fee' do
        expect(calculator.maximum_fee_for_lack_of_notice).to be_within(1e-6).of(20 * 16)
      end
    end

    context 'when the contract starts on a bank holiday' do
      let(:contract_start_date) { start_of_1st_week - 1.week }

      it 'calculates the daily supplier fee based on daily fee' do
        expect(calculator.daily_supplier_fee).to be_within(1e-6).of(10)
      end

      it 'calculates the ideal hire date as the start of the 13th week to avoid paying an early hire fee' do
        expect(calculator.ideal_hire_date).to eq(start_of_13th_week - 1.week + 1.day)
      end

      it 'calculates the ideal notice date as the start of the 9th week to avoid paying a lack of notice fee' do
        expect(calculator.ideal_notice_date).to eq(start_of_9th_week - 1.week + 1.day)
      end
    end

    context 'when the contract start day is on a Saturday' do
      let(:contract_start_date) { start_of_1st_week - 2.days }

      it 'calculates the daily supplier fee based on daily fee' do
        expect(calculator.daily_supplier_fee).to be_within(1e-6).of(10)
      end

      it 'calculates the ideal hire date as the start of the 13th week to avoid paying an early hire fee' do
        expect(calculator.ideal_hire_date).to eq(start_of_13th_week)
      end

      it 'calculates the ideal notice date as the start of the 9th week to avoid paying a lack of notice fee' do
        expect(calculator.ideal_notice_date).to eq(start_of_9th_week)
      end
    end

    context 'when the worker works fewer than 5 days per week' do
      let(:days_per_week) { 2 }

      it 'calculates the maximum fee for lack of notice as 20 days of the pro rata daily supplier fee' do
        expect(calculator.maximum_fee_for_lack_of_notice).to be_within(1e-6).of(20 * 4)
      end

      it 'calculates the ideal hire date as the start of the 13th week to avoid paying an early hire fee' do
        expect(calculator.ideal_hire_date).to eq(start_of_13th_week)
      end

      it 'calculates the ideal notice date as the start of the 9th week to avoid paying a lack of notice fee' do
        expect(calculator.ideal_notice_date).to eq(start_of_9th_week)
      end

      it 'returns the number of days notice required' do
        expect(calculator.days_notice_required).to eq(
          described_class::WORKING_DAYS_NOTICE_PERIOD_REQUIRED_TO_AVOID_LATE_NOTICE_FEE
        )
      end
    end
  end

  context 'when there are two weeks of school holidays between the start of the contract and the hire date' do
    let(:holiday_1_start_date) { start_of_2nd_week }
    let(:holiday_1_end_date) { start_of_2nd_week.end_of_week }
    let(:holiday_2_start_date) { start_of_5th_week }
    let(:holiday_2_end_date) { start_of_5th_week.end_of_week }

    let(:hire_date) { start_of_13th_week }

    it 'calculates the number of working days between the start date and hire date' do
      expect(calculator.working_days_count).to eq(50)
    end

    it 'calculates the ideal hire date as the start of the 15th week to take school holidays into account in order to avoid paying an early hire fee' do
      expect(calculator.ideal_hire_date).to eq(start_of_15th_week)
    end

    it 'calculates the ideal notice date as the start of the 11th week to avoid paying a lack of notice fee' do
      expect(calculator.ideal_notice_date).to eq(start_of_11th_week)
    end

    it 'calculates the maximum fee for lack of notice as 20 days of the daily supplier fee' do
      expect(calculator.maximum_fee_for_lack_of_notice).to be_within(1e-6).of(20 * 10)
    end

    context 'and when there is a holiday within four weeks of the ideal hire date' do
      let(:holiday_2_start_date) { start_of_14th_week }
      let(:holiday_2_end_date) { start_of_14th_week.end_of_week }

      it 'calculates the ideal notice date as the start of the 10th week to avoid paying a lack of notice fee' do
        expect(calculator.ideal_notice_date).to eq(start_of_10th_week)
      end
    end

    context 'and when there is a holiday within four weeks of the hire date' do
      let(:holiday_2_start_date) { start_of_12th_week }
      let(:holiday_2_end_date) { start_of_12th_week.end_of_week }

      it 'calculates the notice date based on hire date as the start of the 8th week to take the second holiday into account and avoid paying a lack of notice fee' do
        expect(calculator.notice_date_based_on_hire_date).to eq(start_of_8th_week)
      end
    end
  end

  context 'when there are 3 bank holidays between the start of the contract and the hire date' do
    let(:start_date) { start_of_1st_week + 15.weeks }
    let(:contract_start_date) { start_date }
    let(:hire_date) { start_date + 12.weeks }

    it 'calculates the ideal notice date as the 3rd day of the 8th week to avoid paying a lack of notice fee' do
      expect(calculator.ideal_notice_date).to eq(start_date + 8.weeks + 3.days)
    end

    it 'calculates the maximum fee for lack of notice as 20 days of the daily supplier fee' do
      expect(calculator.maximum_fee_for_lack_of_notice).to be_within(1e-6).of(20 * 10)
    end

    context 'when worker works fewer than 5 days a week' do
      let(:days_per_week) { 3 }

      it 'calculates the ideal notice date as the start of the 11th week to avoid paying a lack of notice fee' do
        expect(calculator.ideal_notice_date).to eq(start_date + 12.weeks - 4.weeks + 3.days)
      end

      it 'calculates the maximum fee for lack of notice as 20 days of the daily supplier fee' do
        expect(calculator.maximum_fee_for_lack_of_notice).to be_within(1e-6).of(20 * 6)
      end
    end
  end

  context 'when the bank holiday is at the start of the contract' do
    let(:start_date) { start_of_1st_week - 1.week }
    let(:contract_start_date) { start_date }
    let(:hire_date) { start_date + 12.weeks }

    it 'calculates the ideal notice date as the 3rd day of the 8th week to avoid paying a lack of notice fee' do
      expect(calculator.ideal_notice_date).to eq(start_date + 8.weeks + 1.day)
    end

    context 'when worker works fewer than 5 days a week' do
      let(:days_per_week) { 3 }

      it 'calculates the ideal notice date as the start of the 11th week to avoid paying a lack of notice fee' do
        expect(calculator.ideal_notice_date).to eq(start_date + 12.weeks - 4.weeks + 1.day)
      end
    end
  end

  context 'when the school hires the worker within the first 8 weeks (40 working days) of their contract' do
    let(:hire_date) { start_of_4th_week }

    it { is_expected.to be_hiring_within_8_weeks }
    it { is_expected.not_to be_hiring_between_9_and_12_weeks }
    it { is_expected.not_to be_hiring_after_12_weeks }

    it 'calculates the number of working days between the start date and hire date' do
      expect(calculator.working_days_count).to eq(15)
    end

    it 'calculates the number of chargeable working days due to early hire as the difference between the minimum of 60 (12 weeks) and the number of days worked' do
      expect(calculator.chargeable_working_days_based_on_early_hire).to eq(45)
    end

    it 'returns 0 days for lack of notice' do
      expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
    end

    it 'indicates that the school is not required to give any notice' do
      expect(calculator.notice_period_required?).to be(false)
    end

    it 'does not calculate an ideal notice date as notice is not required' do
      expect(calculator.notice_date_based_on_hire_date).to be_nil
    end

    it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
      expect(calculator.fee).to be_within(1e-6).of(45 * 10)
    end

    context 'when the school gives less than 4 weeks notice' do
      let(:notice_date) { start_of_3rd_week }

      it 'returns 0 days for lack of notice as notice is not required within the first 8 weeks' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
      end
    end
  end

  context 'when the school hires the worker within the first 9 to 12 weeks (40 to 60 working days) of their contract' do
    let(:hire_date) { start_of_12th_week }

    it { is_expected.not_to be_hiring_within_8_weeks }
    it { is_expected.to be_hiring_between_9_and_12_weeks }
    it { is_expected.not_to be_hiring_after_12_weeks }

    it 'calculates the number of working days between the start date and hire date' do
      expect(calculator.working_days_count).to eq(55)
    end

    it 'calculates the number of chargeable working days due to early hire as the difference between the minimum of 60 (12 weeks) and the number of days worked' do
      expect(calculator.chargeable_working_days_based_on_early_hire).to eq(5)
    end

    it 'returns 0 days for lack of notice' do
      expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
    end

    it 'calculates the number of chargeable working days as the number of chargeable working days due to early hire' do
      expect(calculator.chargeable_working_days).to eq(5)
    end

    it 'indicates that the school is required to give 4 weeks notice' do
      expect(calculator.notice_period_required?).to be(true)
    end

    it 'calculates the ideal notice date as 4 weeks before the hire date' do
      expect(calculator.notice_date_based_on_hire_date).to eq(start_of_8th_week)
    end

    it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
      expect(calculator.fee).to be_within(1e-6).of(5 * 10)
    end

    context 'when daily fee is 16' do
      let(:daily_fee) { 16 }

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(5 * 16)
      end
    end

    context 'and they give 4 weeks notice' do
      let(:notice_date) { start_of_8th_week }

      it { is_expected.to be_enough_notice }

      it 'calculates the number of days notice given' do
        expect(calculator.days_notice_given).to eq(20)
      end

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(5)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(5 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(5 * 16)
        end
      end
    end

    context 'and they give 3 weeks notice' do
      let(:notice_date) { start_of_9th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of days notice given' do
        expect(calculator.days_notice_given).to eq(15)
      end

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(5)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(5 + 5)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(10 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(10 * 16)
        end
      end
    end

    context 'and they give 2 weeks notice' do
      let(:notice_date) { start_of_10th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of days notice given' do
        expect(calculator.days_notice_given).to eq(10)
      end

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(10)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(10 + 5)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(15 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(15 * 16)
        end
      end
    end

    context 'and they give 1 weeks notice' do
      let(:notice_date) { start_of_11th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of days notice given' do
        expect(calculator.days_notice_given).to eq(5)
      end

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(15)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(15 + 5)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(20 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(20 * 16)
        end
      end
    end

    context 'and they give no notice' do
      let(:notice_date) { start_of_12th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of days notice given' do
        expect(calculator.days_notice_given).to eq(0)
      end

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(20)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(20)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(20 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(20 * 16)
        end
      end
    end
  end

  context 'when the school hires the worker after 12 weeks (60 working days) of their contract' do
    let(:hire_date) { start_of_13th_week }

    it { is_expected.not_to be_hiring_within_8_weeks }
    it { is_expected.not_to be_hiring_between_9_and_12_weeks }
    it { is_expected.to be_hiring_after_12_weeks }

    it 'calculates the number of working days between the start date and hire date' do
      expect(calculator.working_days_count).to eq(60)
    end

    it 'calculates the number of chargeable working days due to early hire as the difference between the minimum of 60 (12 weeks) and the number of days worked' do
      expect(calculator.chargeable_working_days_based_on_early_hire).to eq(0)
    end

    it 'returns 0 days for lack of notice' do
      expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
    end

    it 'calculates the number of chargeable working days as zero' do
      expect(calculator.chargeable_working_days).to eq(0)
    end

    it 'indicates that the school is required to give 4 weeks notice' do
      expect(calculator.notice_period_required?).to be(true)
    end

    it 'calculates the ideal notice date as 4 weeks before the hire date' do
      expect(calculator.notice_date_based_on_hire_date).to eq(start_of_9th_week)
    end

    it 'calculates the fee as zero' do
      expect(calculator.fee).to be_within(1e-6).of(0)
    end

    context 'when daily fee is 16' do
      let(:daily_fee) { 16 }

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(0)
      end
    end

    context 'and they give 4 weeks notice' do
      let(:notice_date) { start_of_9th_week }

      it { is_expected.to be_enough_notice }

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(0)
      end

      it 'calculates the fee as zero' do
        expect(calculator.fee).to be_within(1e-6).of(0)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(0)
        end
      end
    end

    context 'and they give 3 weeks notice' do
      let(:notice_date) { start_of_10th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(5)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(5)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(5 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(5 * 16)
        end
      end
    end

    context 'and they give 2 weeks notice' do
      let(:notice_date) { start_of_11th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(10)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(10)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(10 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(10 * 16)
        end
      end
    end

    context 'and they give 1 weeks notice' do
      let(:notice_date) { start_of_12th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(15)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(15)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(15 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(15 * 16)
        end
      end
    end

    context 'and they give no notice' do
      let(:notice_date) { start_of_13th_week }

      it { is_expected.not_to be_enough_notice }

      it 'calculates the number of chargeable working days due to lack of notice as the difference between the minimum of 40 (4 weeks) and the number of days notice given' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(20)
      end

      it 'calculates the number of chargeable working days as those due to early hire plus those due to lack of notice but caps it at 20' do
        expect(calculator.chargeable_working_days).to eq(20)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(20 * 10)
      end

      context 'when daily fee is 16' do
        let(:daily_fee) { 16 }

        it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
          expect(calculator.fee).to be_within(1e-6).of(20 * 16)
        end
      end
    end
  end

  context 'when hire date is more than 12 weeks after contract start date' do
    let(:hire_date) { start_of_14th_week }

    it 'returns 0 if number of charchable days is < 0' do
      expect(calculator.chargeable_working_days_based_on_early_hire).to eq(0)
    end

    it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
      expect(calculator.fee).to be_within(1e-6).of(0)
    end

    context 'and notice date is less than 4 weeks' do
      let(:notice_date) { start_of_14th_week - 4.weeks + 2.days }

      it 'returns 0 if number of chargeable days is < 0' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(2)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(2 * 10)
      end
    end

    context 'and notice date is more than 4 weeks' do
      let(:notice_date) { start_of_14th_week - 5.weeks }

      it 'returns 0 if number of chargeable days is < 0' do
        expect(calculator.chargeable_working_days_based_on_lack_of_notice).to eq(0)
      end

      it 'calculates the fee as the number of chargeable working days multiplied by the daily supplier fee' do
        expect(calculator.fee).to be_within(1e-6).of(0)
      end
    end
  end

  describe '#working_days_count' do
    context 'when the working period includes a bank holiday in England' do
      let(:august_bank_holiday) { Date.parse('Monday, 27th August 2018') }
      let(:contract_start_date) { august_bank_holiday }
      let(:hire_date) { Date.parse('Monday, 3rd September 2018') }

      it 'excludes the bank holiday in the calculation' do
        expect(calculator.working_days_count).to eq(4)
      end
    end
  end

  describe '#before_national_deal_began?' do
    context 'when the contract start date is before 5 July 2022' do
      let(:contract_start_date) { Date.parse('4 July 2022') }

      it 'is true' do
        expect(calculator.before_national_deal_began?).to be true
      end
    end

    context 'when the contract start date is on or after 5 July 202' do
      let(:contract_start_date) { Date.parse('5 July 2022') }

      it 'is false' do
        expect(calculator.before_national_deal_began?).to be false
      end
    end
  end
end
