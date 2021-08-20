require 'rails_helper'

RSpec.describe ManagementConsultancy::JourneyHelper, type: :helper do
  describe '#lot_number_and_description' do
    it 'returns the full title with lot and description' do
      lot_number = 'MCF1.2'
      description = 'Business consultancy'

      expect(helper.lot_number_and_description(lot_number, description)).to eq('Lot 2 - Business consultancy')
    end
  end
end
