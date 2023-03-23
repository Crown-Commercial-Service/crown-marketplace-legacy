require 'rails_helper'

RSpec.describe ManagementConsultancy::JourneyHelper do
  describe '#lot_number_and_description' do
    it 'returns the full title with lot and description' do
      lot_number = 'MCF3.2'
      description = 'Strategy and Policy'

      expect(helper.lot_number_and_description(lot_number, description)).to eq('Lot 2 - Strategy and Policy')
    end
  end

  describe '#framework_lot_and_description' do
    context 'when the lot is in MCF3' do
      it 'returns the full title with lot, framework and description' do
        lot_number = 'MCF3.1'
        description = 'Business'

        expect(helper.framework_lot_and_description(lot_number, description)).to eq('MCF3 lot 1 - Business')
      end
    end
  end
end
