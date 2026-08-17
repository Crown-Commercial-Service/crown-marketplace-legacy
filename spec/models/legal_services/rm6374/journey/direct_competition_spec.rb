require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::DirectCompetition, type: :model do
  subject(:step) { described_class.new }

  describe 'attributes' do
    it { is_expected.to respond_to(:lot_number) }
    it { is_expected.to respond_to(:call_off_mechanism) }
  end

  describe '#lot' do
    let(:lot_number) { '1' }
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

  describe '#supplier_frameworks' do
    let(:lot_number) { '1' }
    let(:expected_lot_id) { "RM6374.#{lot_number}" }
    let(:lot_mock) { instance_double(Lot, id: expected_lot_id) }

    before do
      step.lot_number = lot_number
      # The method relies on `#lot` which calls `Lot.find`
      allow(Lot).to receive(:find).with(expected_lot_id).and_return(lot_mock)
    end

    context 'when service_numbers in params are empty or all blank' do
      it 'returns an empty array when service_numbers is nil' do
        expect(step.supplier_frameworks({})).to eq([])
      end

      it 'returns an empty array when service_numbers contains only blank values' do
        expect(step.supplier_frameworks(service_numbers: ['', nil, '  '])).to eq([])
      end
    end

    context 'when service_numbers are provided in params' do
      let(:frameworks_mock) { [instance_double(Supplier::Framework)] }
      let(:expected_service_codes) { ["#{expected_lot_id}.1", "#{expected_lot_id}.2"] }

      before do
        allow(Supplier::Framework).to receive(:with_services)
          .with(expected_service_codes)
          .and_return(frameworks_mock)
      end

      it 'compacts blanks, maps codes correctly, and returns the frameworks' do
        params = { service_numbers: ['1', '', nil, '2'] }
        expect(step.supplier_frameworks(params)).to eq(frameworks_mock)
      end
    end
  end

  describe '#next_step_class' do
    it 'returns nil' do
      expect(step.next_step_class).to be_nil
    end
  end
end