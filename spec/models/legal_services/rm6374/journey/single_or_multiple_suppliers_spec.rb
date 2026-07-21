require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::SingleOrMultipleSuppliers do
  subject(:step) { described_class.new(lot_number:, single_or_multiple_suppliers:) }

  let(:lot_number) { '2' }
  let(:single_or_multiple_suppliers) { 'single' }

  describe 'validations' do
    context 'when no option is provided' do
      let(:single_or_multiple_suppliers) { '' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:single_or_multiple_suppliers].first).to eq 'Select an option to continue'
      end
    end

    context 'when an invalid option is provided' do
      let(:single_or_multiple_suppliers) { 'invalid-option' }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:single_or_multiple_suppliers].first).to eq 'Select an option to continue'
      end
    end

    context 'when a valid option is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '#lot' do
    it 'returns the lot for RM6374 with the given number' do
      framework = Framework.find_by(id: 'RM6374') || create(:framework, id: 'RM6374')
      lot = Lot.find_by(id: "RM6374.#{lot_number}") || create(:lot, number: lot_number, framework: framework)

      expect(step.lot).to eq(lot)
    end
  end

  describe '.next_step_class' do
    context 'when a single supplier option is selected' do
      it 'returns Journey::ChooseJurisdiction' do
        expect(step.next_step_class).to be LegalServices::RM6374::Journey::ChooseJurisdiction
      end
    end

    context 'when multiple supplier options are selected' do
      let(:single_or_multiple_suppliers) { 'multiple' }

      it 'returns Journey::SelectLot' do
        expect(step.next_step_class).to be LegalServices::RM6374::Journey::SelectLot
      end
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq([:lot_number, :single_or_multiple_suppliers, {}])
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq(%i[lot_number single_or_multiple_suppliers])
    end
  end

  describe '.template' do
    it 'returns journey/single_or_multiple_suppliers' do
      expect(step.template).to eq 'journey/single_or_multiple_suppliers'
    end
  end

  describe '.slug' do
    it 'returns single-or-multiple-suppliers' do
      expect(step.slug).to eq 'single-or-multiple-suppliers'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
