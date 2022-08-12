require 'rails_helper'

RSpec.describe LegalServices::RM6240::Journey::SelectLot, type: :model do
  subject(:step) { described_class.new(lot: lot_number) }

  let(:lot_number) { '1' }

  describe 'validations' do
    context 'when no lot_number is provided' do
      let(:lot_number) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:lot].first).to eq 'Select the lot you need'
      end
    end

    context 'when a lot number is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    context 'and the lot_number is 1' do
      let(:lot_number) { '1' }

      it 'returns Journey::ChooseServices' do
        expect(step.next_step_class).to be LegalServices::RM6240::Journey::ChooseServices
      end
    end

    context 'and the lot_number is 2' do
      let(:lot_number) { '2' }

      it 'returns Journey::ChooseServices' do
        expect(step.next_step_class).to be LegalServices::RM6240::Journey::ChooseServices
      end
    end

    context 'and the lot_number is 3' do
      let(:lot_number) { '3' }

      pending 'returns Journey::Suppliers' do
        expect(step.next_step_class).to be LegalServices::RM6240::Journey::Suppliers
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot, {}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot]
    end
  end

  describe '.slug' do
    it 'returns select-lot' do
      expect(step.slug).to eq 'select-lot'
    end
  end

  describe '.template' do
    it 'returns journey/select_lot' do
      expect(step.template).to eq 'journey/select_lot'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end

  describe '.lots' do
    let(:result) { described_class.lots(central_government) }

    context 'when central government is yes' do
      let(:central_government) { 'yes' }

      it 'returns the 2 lots sorted' do
        expect(result.map(&:number)).to eq %w[1 2]
      end
    end

    context 'when central government is no' do
      let(:central_government) { 'no' }

      it 'returns the 3 lots sorted' do
        expect(result.map(&:number)).to eq %w[1 2 3]
      end
    end
  end
end
