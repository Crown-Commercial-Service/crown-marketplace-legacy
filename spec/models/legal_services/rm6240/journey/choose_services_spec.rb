require 'rails_helper'

RSpec.describe LegalServices::RM6240::Journey::ChooseServices do
  subject(:step) { described_class.new(service_ids:, lot_id:) }

  let(:lot_id) { 'RM6240.1' }
  let(:service_ids) { %w['RM6240.1.3] }

  describe 'validations' do
    context 'when no services are provided' do
      let(:service_ids) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:service_ids].first).to eq 'Select at least one legal service'
      end
    end

    context 'when a service is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::ChooseJurisdiction' do
      expect(step.next_step_class).to be LegalServices::RM6240::Journey::ChooseJurisdiction
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
      let(:lot_id) { 'RM6240.1' }

      it 'returns the lot' do
        expect(result.id).to eq 'RM6240.1'
        expect(result.name).to eq 'Full service provision'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_id) { 'RM6240.4' }

      it 'returns nil' do
        expect { result }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '.lot_services' do
    let(:result) { step.lot_services }

    context 'when the lot number is 1' do
      it 'returns a list of 40 services' do
        expect(result.length).to eq(40)
      end

      it 'sets the first service is Administrative and Public Law' do
        expect(result.first.id).to eq('RM6240.1.1')
        expect(result.first.name).to eq('Administrative and Public Law')
      end
    end

    context 'when the lot number is 2' do
      let(:lot_id) { 'RM6240.2' }

      it 'returns a list of 15 services' do
        expect(result.length).to eq(15)
      end

      it 'sets the first service is Child Law' do
        expect(result.first.id).to eq('RM6240.2.3')
        expect(result.first.name).to eq('Child Law')
      end
    end
  end
end
