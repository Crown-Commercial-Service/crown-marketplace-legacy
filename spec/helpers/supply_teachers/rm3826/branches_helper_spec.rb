require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::BranchesHelper, type: :helper do
  describe '.link_to_calculator?' do
    before { helper.params[:payroll_provider] = payroll_provider }

    context 'when the is payroll_provider is school' do
      let(:payroll_provider) { 'school' }

      it 'returns false' do
        expect(helper.link_to_calculator?).to be false
      end
    end

    context 'when the is payroll_provider is agency' do
      let(:payroll_provider) { 'agency' }

      it 'returns true' do
        expect(helper.link_to_calculator?).to be true
      end
    end
  end

  describe '.daily_fee_or_markup' do
    let(:branch) { build(:supply_teachers_branch_search_result) }

    it 'returns the number as a percentage' do
      branch.rate = 0.435

      expect(helper.daily_fee_or_markup(branch)).to eq '43.5%'
    end
  end

  describe '.finders_fee' do
    it 'returns the number as a percentage' do
      expect(helper.finders_fee(0.534)).to eq '53.4%'
    end
  end

  describe '.agency_sorted_rates' do
    let(:supplier) { create(:supply_teachers_rm3826_supplier) }

    let(:rate1) { create(:supply_teachers_rm3826_rate, supplier: supplier, job_type: 'qt', term: 'one_week') }
    let(:rate2) { create(:supply_teachers_rm3826_rate, supplier: supplier, job_type: 'qt', term: 'twelve_weeks') }
    let(:rate3) { create(:supply_teachers_rm3826_rate, supplier: supplier, job_type: 'qt', term: 'more_than_twelve_weeks') }

    before do
      rate3
      rate1
      rate2
    end

    it 'sorts the rates by the job tyoe' do
      expect(helper.agency_sorted_rates(supplier.rates)).to eq [
        rate1,
        rate2,
        rate3
      ]
    end
  end
end
