require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::ChooseSpecialisms do
  subject(:step) { described_class.new(sector:, service_numbers:) }

  let(:sector) { 'health' }
  let(:service_numbers) { %w[1 2 3] }

  describe 'validations' do
    context 'when no service_numbers are provided' do
      let(:service_numbers) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:service_numbers].first).to eq 'Select at least one legal specialism'
      end
    end

    context 'when an option that is in the list provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.specialisms' do
    let(:result) { step.specialisms }

    context 'when the sector is transport' do
      let(:sector) { 'transport' }

      it 'returns the transport specialisms only' do
        expect(result.count).to eq(9)
      end
    end

    context 'when the sector is not transport' do
      it 'returns the non transport specialisms only' do
        expect(result.count).to eq(83)
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::SelectLot' do
      expect(step.next_step_class).to be LegalServices::RM6374::Journey::SelectLot
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:sector, { service_numbers: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[sector service_numbers]
    end
  end

  describe '.slug' do
    it 'returns choose-specialisms' do
      expect(step.slug).to eq 'choose-specialisms'
    end
  end

  describe '.template' do
    it 'returns journey/choose_specialisms' do
      expect(step.template).to eq 'journey/choose_specialisms'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
