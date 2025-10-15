require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::ChooseServices do
  subject(:step) { described_class.new(service_ids:, lot_id:) }

  let(:lot_id) { 'RM6360.1' }
  let(:service_ids) { %w[RM6360.1.1] }

  describe 'validations' do
    context 'when no services are provided' do
      let(:service_ids) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:service_ids].first).to eq 'Select at least one legal specialism'
      end
    end

    context 'when a service is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::SupplierResults' do
      expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::SupplierResults
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, { service_ids: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id service_ids]
    end
  end

  describe '.slug' do
    it 'returns choose-services' do
      expect(step.slug).to eq 'choose-services'
    end
  end

  describe '.template' do
    it 'returns journey/choose_services' do
      expect(step.template).to eq 'journey/choose_services'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.lot' do
    let(:result) { step.lot }

    context 'when the lot exists' do
      it 'returns the lot' do
        expect(result.id).to eq 'RM6360.1'
        expect(result.name).to eq 'Core Legal Services'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_id) { 'RM6360.6' }

      it 'returns nil' do
        expect { result }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '.lot_services' do
    let(:result) { step.lot_services }

    context 'when the lot number is 1' do
      it 'returns a list of 48 services' do
        expect(result.length).to eq(48)
      end

      it 'sets the first service is Assimilated Law' do
        expect(result.first.id).to eq('RM6360.1.1')
        expect(result.first.name).to eq('Assimilated Law')
      end
    end

    context 'when the lot number is 4a' do
      let(:lot_id) { 'RM6360.4a' }

      it 'returns a list of 10 services' do
        expect(result.length).to eq(10)
      end

      it 'sets the first service is Assimilated Law' do
        expect(result.first.id).to eq('RM6360.4a.1')
        expect(result.first.name).to eq('Assimilated Law')
      end
    end
  end
end
