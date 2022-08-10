require 'rails_helper'

RSpec.describe LegalServices::RM3788::Journey::ChooseRegions, type: :model do
  subject(:step) { described_class.new(region_codes: region_codes) }

  let(:region_codes) { %w[UKC] }

  describe 'validations' do
    context 'when no region_codes are provided' do
      let(:region_codes) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:region_codes].first).to eq 'Select the region or regions you require the services in'
      end
    end

    context 'when region_codes includes full national coverage' do
      context 'and other regions are included' do
        let(:region_codes) { %w[UKC UK] }

        it 'is not valid and has the correct error message' do
          expect(step).not_to be_valid
          expect(step.errors[:region_codes].first).to eq 'Select full national coverage or the region or regions you require the services in'
        end
      end

      context 'and it is only full national coverage' do
        let(:region_codes) { %w[UK] }

        it 'is valid' do
          expect(step).to be_valid
        end
      end
    end

    context 'when a specific UK region is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::Suppliers' do
      expect(step.next_step_class).to be LegalServices::RM3788::Journey::Suppliers
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [{ region_codes: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[region_codes]
    end
  end

  describe '.slug' do
    it 'returns choose-regions' do
      expect(step.slug).to eq 'choose-regions'
    end
  end

  describe '.template' do
    it 'returns journey/choose_regions' do
      expect(step.template).to eq 'journey/choose_regions'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.lot' do
    let(:result) { step.lot(lot_number) }

    context 'when the lot exists' do
      let(:lot_number) { '1' }

      it 'returns the lot' do
        expect(result.number).to eq '1'
        expect(result.description).to eq 'Regional service provision'
      end
    end

    context 'when the lot does not exist' do
      let(:lot_number) { '5' }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end
