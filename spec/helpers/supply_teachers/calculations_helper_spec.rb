require 'rails_helper'

RSpec.describe SupplyTeachers::CalculationsHelper, type: :helper do
  describe 'determine_result_partial' do
    let(:result) { helper.determine_result_partial }
    let(:calculator) { instance_double('SupplyTeachers::TempToPermCalculator::Calculator') }
    let(:hiring_after_12_weeks) { false }
    let(:hiring_between_9_and_12_weeks) { false }
    let(:notice_date) { Time.now.in_time_zone('London') }
    let(:enough_notice) { false }

    before do
      allow(calculator).to receive(:hiring_after_12_weeks?).and_return(hiring_after_12_weeks)
      allow(calculator).to receive(:hiring_between_9_and_12_weeks?).and_return(hiring_between_9_and_12_weeks)
      allow(calculator).to receive(:notice_date).and_return(notice_date)
      allow(calculator).to receive(:enough_notice?).and_return(enough_notice)
      @calculator = calculator
    end

    context 'when the hiring after 12 weeks' do
      let(:hiring_after_12_weeks) { true }

      context 'and the notice period is long enough' do
        let(:enough_notice) { true }

        it 'returns after_12_weeks_and_enough_notice' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/after_12_weeks_and_enough_notice'
        end
      end

      context 'and the notice period is not long enough' do
        it 'returns after_12_weeks_and_not_enough_notice' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/after_12_weeks_and_not_enough_notice'
        end
      end

      context 'and there is no notice period' do
        let(:notice_date) { nil }

        it 'returns after_12_weeks_and_no_notice_date' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/after_12_weeks_and_no_notice_date'
        end
      end
    end

    context 'when hiring between 9 and 12 weeks' do
      let(:hiring_between_9_and_12_weeks) { true }

      context 'and the notice period is long enough' do
        let(:enough_notice) { true }

        it 'returns between_9_and_12_weeks_and_enough_notice' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/between_9_and_12_weeks_and_enough_notice'
        end
      end

      context 'and the notice period is not long enough' do
        it 'returns between_9_and_12_weeks_and_not_enough_notice' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/between_9_and_12_weeks_and_not_enough_notice'
        end
      end

      context 'and there is no notice period' do
        let(:notice_date) { nil }

        it 'returns between_9_and_12_weeks_and_no_notice_date' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/between_9_and_12_weeks_and_no_notice_date'
        end
      end
    end

    context 'when hiring 8 weeks or before' do
      context 'and the notice period is long enough' do
        let(:enough_notice) { true }

        it 'returns within_first_8_weeks' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/within_first_8_weeks'
        end
      end

      context 'and the notice period is not long enough' do
        it 'returns within_first_8_weeks' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/within_first_8_weeks'
        end
      end

      context 'and there is no notice period' do
        let(:notice_date) { nil }

        it 'returns within_first_8_weeks' do
          expect(result).to eq 'supply_teachers/calculations/temp_to_perm_fee/within_first_8_weeks'
        end
      end
    end
  end
end
