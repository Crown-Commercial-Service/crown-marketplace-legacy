require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::SuppliersHelper, type: :helper do
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

  describe 'show_path' do
    let(:supplier) { create(:supply_teachers_rm3826_supplier) }
    let(:branch) { create(:supply_teachers_rm3826_branch, supplier: supplier) }

    it 'returns the show path for the supplier' do
      expect(helper.show_path(branch)).to eq supply_teachers_rm3826_supplier_path(supplier)
    end
  end
end
