require 'rails_helper'

RSpec.describe LegalServices::RM6374::Journey::CompareSelectSuppliers do
  subject(:step) do
    described_class.new(
      lot_number:,
      jurisdiction:,
      service_numbers:,
      supplier_framework_ids:
    )
  end

  let(:lot_number) { '1' }
  let(:jurisdiction) { 'a' }
  let(:service_numbers) { %w[2 3] }
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
    let(:selected_services) { %w[RM6374.1.2 RM6374.1.3] }
    let(:selected_jurisdiction_id) { 'RM6374.EW' }

    let(:supplier_z) { instance_double(Supplier, name: 'Zebra Law') }
    let(:supplier_a) { instance_double(Supplier, name: 'Alpha Legal') }

    let(:framework_z) { instance_double(Supplier::Framework, supplier: supplier_z, supplier_name: 'Zebra Law') }
    let(:framework_a) { instance_double(Supplier::Framework, supplier: supplier_a, supplier_name: 'Alpha Legal') }

    let(:frameworks_relation) { double('supplier_frameworks_relation') } # rubocop:disable RSpec/VerifiedDoubles

    before do
      allow(Lot).to receive(:find).with('RM6374.1').and_return(lot)
      allow(Supplier::Framework).to receive(:with_lots).with(lot.id).and_return(frameworks_relation)
      allow(frameworks_relation).to receive(:with_services_and_jurisdiction)
        .with(selected_services, [selected_jurisdiction_id])
        .and_return([framework_z, framework_a])
    end

    it 'returns the supplier frameworks sorted by supplier name' do
      expect(step.available_suppliers).to eq([framework_a, framework_z])
    end

    context 'when the jurisdiction is not mapped' do
      let(:jurisdiction) { 'RM6374.GB' }
      let(:selected_jurisdiction_id) { 'RM6374.GB' }

      it 'passes the jurisdiction through unchanged' do
        step.available_suppliers

        expect(frameworks_relation).to have_received(:with_services_and_jurisdiction)
          .with(selected_services, [selected_jurisdiction_id])
      end
    end

    context 'when the jurisdiction maps to Scotland' do
      let(:jurisdiction) { 'b' }
      let(:selected_jurisdiction_id) { 'RM6374.SC' }

      it 'translates the jurisdiction code using JURISDICTION_MAP' do
        step.available_suppliers

        expect(frameworks_relation).to have_received(:with_services_and_jurisdiction)
          .with(selected_services, [selected_jurisdiction_id])
      end
    end
  end
end
