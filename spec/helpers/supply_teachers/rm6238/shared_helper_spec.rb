require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SharedHelper, type: :helper do
  let(:supplier) { create(:supply_teachers_rm6238_supplier) }
  let(:rate_teacher_1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'daily') }
  let(:rate_teacher_2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus') }
  let(:rate_support_1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'support', term: 'daily') }
  let(:rate_support_2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'support', term: 'six_weeks_plus') }
  let(:rate_senior_1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'senior', term: 'daily') }
  let(:rate_senior_2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'senior', term: 'six_weeks_plus') }
  let(:rate_other_1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'other', term: 'daily') }
  let(:rate_other_2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'other', term: 'six_weeks_plus') }
  let(:rate_over_12_week) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'over_12_week') }
  let(:rate_nominated) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'nominated') }
  let(:rate_fixed_term) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'fixed_term') }

  describe '.grouped_rates_sorted_by_job_type' do
    let(:unsorted_grouped_rates) do
      [
        [
          'support',
          [rate_support_1, rate_support_2]
        ],
        [
          'fixed_term',
          [rate_fixed_term]
        ],
        [
          'senior',
          [rate_senior_1, rate_senior_2]
        ],
        [
          'nominated',
          [rate_nominated]
        ],
        [
          'other',
          [rate_other_1, rate_other_2]
        ],
        [
          'over_12_week',
          [rate_over_12_week]
        ],
        [
          'teacher',
          [rate_teacher_1, rate_teacher_2]
        ]
      ]
    end

    let(:sorted_grouped_rates) do
      [
        [
          'teacher',
          [rate_teacher_1, rate_teacher_2]
        ],
        [
          'support',
          [rate_support_1, rate_support_2]
        ],
        [
          'senior',
          [rate_senior_1, rate_senior_2]
        ],
        [
          'other',
          [rate_other_1, rate_other_2]
        ],
        [
          'over_12_week',
          [rate_over_12_week]
        ],
        [
          'nominated',
          [rate_nominated]
        ],
        [
          'fixed_term',
          [rate_fixed_term]
        ]
      ]
    end

    it 'sorts the rates by job type' do
      expect(helper.grouped_rates_sorted_by_job_type(unsorted_grouped_rates)).to eq(sorted_grouped_rates)
    end
  end

  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rate) }

    context 'when the rate is a percentage' do
      let(:rate) { rate_over_12_week }

      it 'returns the rate as a percentage' do
        expect(result).to eq('<td class="govuk-table__cell govuk-table__cell--numeric agency-record__markup-column">30.0%</td>')
      end
    end

    context 'when the rate is a price' do
      let(:rate) { rate_nominated }

      it 'returns the rate as a price' do
        expect(result).to eq('<td class="govuk-table__cell govuk-table__cell--numeric agency-record__markup-column">£30.00</td>')
      end
    end
  end

  describe '.agency_sorted_rates' do
    it 'returns the rates sorted by the term' do
      expect(helper.agency_sorted_rates([rate_teacher_2, rate_teacher_1])).to eq([rate_teacher_1, rate_teacher_2])
    end
  end
end
