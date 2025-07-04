require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::SuppliersHelper do
  let(:lot_number) { rand(1..10).to_s }
  let(:lot) { Lot.find_by(framework_id: 'RM6309', number: lot_number) }

  describe '.rate_position_types' do
    before { @lot = lot }

    (1..9).each do |index|
      context "when the lot number is #{index}" do
        let(:lot_number) { index.to_s }

        it 'returns the normal positions' do
          expect(helper.rate_position_types).to eq(
            {
              names: ['Advice', 'Delivery',],
              offset: 19
            }
          )
        end
      end
    end

    context 'when the lot number is 10' do
      let(:lot_number) { '10' }

      it 'returns the other positions' do
        expect(helper.rate_position_types).to eq(
          {
            names: ['Complex', 'Non-Complex'],
            offset: 31
          }
        )
      end
    end
  end
end
