require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::BranchesHelper do
  let(:rate) { create(:supplier_framework_lot_rate, rate: 4321) }

  describe '.link_to_calculator?' do
    it 'returns false' do
      expect(helper.link_to_calculator?).to be false
    end
  end

  describe '.daily_fee_or_markup' do
    let(:branch) { build(:supply_teachers_branch_search_result) }

    it 'returns the number as currency' do
      branch.rate = rate

      expect(helper.daily_fee_or_markup(branch)).to eq '£43.21'
    end
  end

  describe '.finders_fee' do
    it 'returns the number as a percentage' do
      expect(helper.finders_fee(rate)).to eq '43.2%'
    end
  end

  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rates, position) }
    let(:position) { Position.find(position_id) }
    let(:rate) { create(:supplier_framework_lot_rate, position_id: position.id, rate: 4321) }
    let(:rates) { { position.id => rate } }

    context 'when the rate is a percentage' do
      let(:position_id) { 'RM6238.1.9' }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '43.2%'
      end
    end

    context 'when the rate is not a percentage' do
      let(:position_id) { 'RM6238.1.10' }

      it 'returns the rate as a percentage' do
        expect(result[:text]).to eq '£43.21'
      end
    end
  end
end
