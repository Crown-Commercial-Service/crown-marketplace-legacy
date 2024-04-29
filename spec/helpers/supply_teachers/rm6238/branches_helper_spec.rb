require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::BranchesHelper do
  describe '.link_to_calculator?' do
    it 'returns false' do
      expect(helper.link_to_calculator?).to be false
    end
  end

  describe '.daily_fee_or_markup' do
    let(:branch) { build(:supply_teachers_branch_search_result) }

    it 'returns the number as currency' do
      branch.rate = 43.21

      expect(helper.daily_fee_or_markup(branch)).to eq '£43.21'
    end
  end

  describe '.finders_fee' do
    it 'returns the number as a percentage' do
      expect(helper.finders_fee(43.21)).to eq '43.2%'
    end
  end

  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rate) }

    context 'when the rate is a percentage' do
      let(:rate) { create(:supply_teachers_rm6238_rate, job_type: 'fixed_term', rate: 4321) }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '43.2%'
      end
    end

    context 'when the rate is not a percentage' do
      let(:rate) { create(:supply_teachers_rm6238_rate, rate: 4321) }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '£43.21'
      end
    end
  end

  describe '.agency_sorted_rates' do
    let(:supplier) { create(:supply_teachers_rm6238_supplier) }

    let(:rate1) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'daily') }
    let(:rate2) { create(:supply_teachers_rm6238_rate, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus') }

    before do
      rate2
      rate1
    end

    it 'sorts the rates by the job tyoe' do
      expect(helper.agency_sorted_rates(supplier.rates)).to eq [
        rate1,
        rate2
      ]
    end
  end
end
