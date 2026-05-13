require 'rails_helper'

RSpec.describe SupplyTeachers::RM6376::RatesHelper do
  let(:position) { Position.find(position_id) }
  let(:rate) { create(:supplier_framework_lot_rate, position_id: position.id, rate: 3000) }
  let(:rates) { { position.id => rate } }

  describe '.agency_rate' do
    let(:result) { helper.agency_rate(rates, position_id) }

    context 'when the rate is a percentage' do
      let(:position_id) { 'RM6376.1.9' }

      it 'returns the rate as a percentage' do
        expect(result).to eq('30.0%')
      end
    end

    context 'when the rate is a price' do
      let(:position_id) { 'RM6376.1.10' }

      it 'returns the rate as a price' do
        expect(result).to eq('£30.00')
      end
    end

    context 'when the rate is not present' do
      let(:position_id) { 'RM6376.1.10' }
      let(:result) { helper.agency_rate(rates, 'RM6376.1.11') }

      it 'returns the rate as a price' do
        expect(result).to eq('N/A')
      end
    end
  end
end
