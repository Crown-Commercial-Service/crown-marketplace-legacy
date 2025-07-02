require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::SuppliersHelper do
  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rate) }

    context 'when the rate is a percentage' do
      let(:rate) { create(:supplier_framework_lot_rate, position_id: 40, rate: 4321) }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '43.2%'
      end
    end

    context 'when the rate is not a percentage' do
      let(:rate) { create(:supplier_framework_lot_rate, position_id: 41, rate: 4321) }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '£43.21'
      end
    end
  end

  describe 'show_path' do
    let(:supplier_framework) { create(:supplier_framework) }

    it 'returns the show path for the supplier' do
      expect(helper.show_path(supplier_framework)).to eq supply_teachers_rm6238_supplier_path(supplier_framework)
    end
  end
end
