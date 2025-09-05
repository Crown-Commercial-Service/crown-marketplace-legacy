require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::RatesHelper do
  let(:rate_over_12_week) { create(:supplier_framework_lot_rate, position_id: 38, rate: 3000) }
  let(:rate_nominated) { create(:supplier_framework_lot_rate, position_id: 39, rate: 3000) }

  describe '.agency_rate_cell' do
    let(:result) { helper.agency_rate_cell(rate) }

    context 'when the rate is a percentage' do
      let(:rate) { rate_over_12_week }

      it 'returns the rate as a percentage' do
        expect(result).to eq({
                               classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column',
                               text: '30.0%'
                             })
      end
    end

    context 'when the rate is a price' do
      let(:rate) { rate_nominated }

      it 'returns the rate as a price' do
        expect(result).to eq({
                               classes: 'govuk-table__cell govuk-table__cell--numeric agency-record__markup-column',
                               text: '£30.00'
                             })
      end
    end
  end
end
