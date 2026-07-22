require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::CompareSelectSuppliers do
  subject(:step) do
    described_class.new(
      lot_number:,
      supplier_framework_ids:
    )
  end

  let(:lot_number) { '1' }
  let(:supplier_framework_ids) { ['supplier-uuid-1'] }

  describe 'attributes' do
    it { is_expected.to respond_to :lot_number }
    it { is_expected.to respond_to :supplier_framework_ids }
  end

  describe 'validations' do
    context 'when supplier_framework_ids is empty' do
      let(:supplier_framework_ids) { [] }

      it 'is not valid' do
        expect(step).not_to be_valid
      end

      it 'adds a too_short error to supplier_framework_ids' do
        step.valid?
        expect(step.errors[:supplier_framework_ids]).to include(
          I18n.t('activemodel.errors.models.legal_services/rm6374/journey/compare_select_suppliers.attributes.supplier_framework_ids.too_short')
        )
      end
    end

    context 'when at least one supplier_framework_id is provided' do
      let(:supplier_framework_ids) { ['supplier-uuid-1'] }

      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '#lot' do
    let(:lot) { instance_double(Lot) }

    before do
      allow(Lot).to receive(:find).with('RM6374.1').and_return(lot)
    end

    it 'finds and returns the correct lot based on the lot_number' do
      expect(step.lot).to eq(lot)
    end
  end

  describe '#available_suppliers' do
    let(:lot) { instance_double(Lot, id: 'RM6374.1') }

    let(:supplier_z) { instance_double(Supplier, name: 'Zebra Law') }
    let(:supplier_a) { instance_double(Supplier, name: 'Alpha Legal') }

    let(:framework_z) { instance_double(Supplier::Framework, supplier: supplier_z) }
    let(:framework_a) { instance_double(Supplier::Framework, supplier: supplier_a) }

    let(:framework_lot_1) { instance_double(Supplier::Framework::Lot, supplier_framework: framework_z) }
    let(:framework_lot_2) { instance_double(Supplier::Framework::Lot, supplier_framework: framework_a) }
    let(:framework_lot_duplicate) { instance_double(Supplier::Framework::Lot, supplier_framework: framework_a) }

    before do
      allow(Lot).to receive(:find).with('RM6374.1').and_return(lot)

      relation_double = instance_double(ActiveRecord::Relation)
      allow(Supplier::Framework::Lot).to receive(:where).with(lot_id: lot.id).and_return(relation_double)
      allow(relation_double).to receive(:includes).with(supplier_framework: :supplier).and_return(
        [framework_lot_1, framework_lot_2, framework_lot_duplicate]
      )
    end

    it 'returns unique supplier frameworks' do
      expect(step.available_suppliers.length).to eq(2)
    end

    it 'sorts the supplier frameworks alphabetically by supplier name' do
      expect(step.available_suppliers).to eq([framework_a, framework_z])
    end
  end
end
