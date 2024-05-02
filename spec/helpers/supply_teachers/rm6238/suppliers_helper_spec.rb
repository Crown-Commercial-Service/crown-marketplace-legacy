require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SuppliersHelper do
  describe '.managed_service_provider_contact' do
    let(:supplier) { create(:supply_teachers_rm6238_supplier) }
    let!(:master_vendor_contact) { create(:supply_teachers_rm6238_managed_service_provider_master_vendor, supplier:) }
    let!(:education_technology_platforms_contact) { create(:supply_teachers_rm6238_managed_service_provider_education_technology_platforms, supplier:) }

    let(:result) { helper.managed_service_provider_contact(supplier, lot_number) }

    context 'when the lot number is 2' do
      let(:lot_number) { '2' }

      it 'returns the master vendor contact' do
        expect(result).to eq master_vendor_contact
      end
    end

    context 'when the lot number is 4' do
      let(:lot_number) { '4' }

      it 'returns the education technology platforms contact' do
        expect(result).to eq education_technology_platforms_contact
      end
    end

    context 'when the lot number is 3' do
      let(:lot_number) { '3' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end

  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rate) }

    context 'when the rate is a percentage' do
      let(:rate) { create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, job_type: 'fixed_term', rate: 4321) }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '43.2%'
      end
    end

    context 'when the rate is not a percentage' do
      let(:rate) { create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, rate: 4321) }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '£43.21'
      end
    end
  end

  describe '.agency_sorted_rates' do
    let(:supplier) { create(:supply_teachers_rm6238_supplier) }

    let(:rate1) { create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, supplier: supplier, job_type: 'teacher', term: 'daily') }
    let(:rate2) { create(:supply_teachers_rm6238_master_vendor_below_threshold_rate, supplier: supplier, job_type: 'teacher', term: 'six_weeks_plus') }

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

  describe 'show_path' do
    let(:supplier) { create(:supply_teachers_rm6238_supplier) }

    it 'returns the show path for the supplier' do
      expect(helper.show_path(supplier)).to eq supply_teachers_rm6238_supplier_path(supplier)
    end
  end
end
