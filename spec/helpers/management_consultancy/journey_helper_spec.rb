require 'rails_helper'

RSpec.describe ManagementConsultancy::JourneyHelper do
  let(:lot_number) { rand(1..10).to_s }
  let(:lot) { Lot.find_by(framework_id: 'RM6309', number: lot_number) }

  describe '#lot_full_description' do
    it 'returns the full title with lot and description' do
      expect(helper.lot_full_name(lot)).to eq("Lot #{lot_number} - #{lot.name}")
    end
  end

  describe '#framework_lot_and_description' do
    context 'when the lot is in MCF3' do
      it 'returns the full title with lot, framework and description' do
        expect(helper.framework_lot_and_description('MCF4', lot)).to eq("MCF4 lot #{lot.number} - #{lot.name}")
      end
    end
  end
end
