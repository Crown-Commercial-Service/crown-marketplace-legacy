require 'rails_helper'

RSpec.describe LegalServices::JourneyHelper do
  let(:lot_number) { rand(1..3).to_s }
  let(:lot) { Lot.find_by(framework_id: 'RM6240', number: lot_number) }

  describe '#lot_full_description' do
    it 'returns the full title with lot and description' do
      expect(helper.lot_full_name(lot)).to eq("Lot #{lot_number} - #{lot.name}")
    end
  end

  describe '#lot_legal_services' do
    it 'returns text containing the correct lot number' do
      expect(helper.lot_legal_services(lot_number)).to eq("Lot #{lot_number} legal services")
    end
  end
end
