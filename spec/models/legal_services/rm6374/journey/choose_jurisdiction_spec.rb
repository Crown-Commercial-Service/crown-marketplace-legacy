require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseJurisdiction do
  subject(:step) { described_class.new }

  describe 'attributes' do
    it { is_expected.to respond_to(:lot_number) }
  end

  describe '#lot' do
    let(:lot_number) { '1a' }
    let(:expected_lot_id) { "RM6374.#{lot_number}" }
    let(:lot_mock) { instance_double(Lot) }

    before do
      step.lot_number = lot_number
      allow(Lot).to receive(:find).with(expected_lot_id).and_return(lot_mock)
    end

    it 'finds the lot using the combined framework and lot number' do
      expect(step.lot).to eq(lot_mock)
    end
  end

  describe '#next_step_class' do
    it 'returns Journey::Suppliers' do
      expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::Suppliers)
    end
  end
end
