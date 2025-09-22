require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::RatesHelper do
  let(:position) { Position.find(position_id) }
  let(:rate) { create(:supplier_framework_lot_rate, position_id: position.id, rate: 3000) }
  let(:rates) { { position.id => rate } }

  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rates, position) }

    context 'when the rate is a percentage' do
      let(:position_id) { 'RM6238.1.9' }

      it 'returns the rate as a percentage' do
        expect(result).to eq({
                               classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column',
                               text: '30.0%'
                             })
      end
    end

    context 'when the rate is a price' do
      let(:position_id) { 'RM6238.1.10' }

      it 'returns the rate as a price' do
        expect(result).to eq({
                               classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column',
                               text: '£30.00'
                             })
      end
    end
  end
end
