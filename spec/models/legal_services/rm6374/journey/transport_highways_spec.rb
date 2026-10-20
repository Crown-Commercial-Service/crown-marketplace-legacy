require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::TransportHighways do
  subject(:step) { described_class.new(service_numbers:) }

  let(:service_numbers) { ['1'] }

  describe 'validations' do
    context 'when valid service_numbers are provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end

    context 'when no service_numbers are provided' do
      let(:service_numbers) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:service_numbers]).to include('Please select a minimum of one legal service to continue')
      end
    end
  end

  describe '#transport_highways' do
    it 'returns distinct services for lot RM6374.5 ordered by number' do
      results = step.transport_highways

      expect(results.length).to eq(23)
      expect(results.first.name).to eq('Assimilated Law')
      expect(results.last.name).to eq('Tax Law')
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::ChooseJurisdiction' do
      expect(step.next_step_class).to eq(LegalServices::RM6374::Journey::ChooseJurisdiction)
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq([:sector, :lot_number, { service_numbers: [] }])
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq(%i[sector lot_number service_numbers])
    end
  end

  describe '.template' do
    it 'returns journey/transport_highways' do
      expect(step.template).to eq('journey/transport_highways')
    end
  end

  describe '.slug' do
    it 'returns transport-highways' do
      expect(step.slug).to eq('transport-highways')
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
