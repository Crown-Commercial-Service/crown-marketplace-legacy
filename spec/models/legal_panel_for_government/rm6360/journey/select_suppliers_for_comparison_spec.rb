require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::SelectSuppliersForComparison do
  subject(:step) { described_class.new(supplier_framework_ids:, service_ids:, lot_id:, jurisdiction_ids:, not_core_jurisdiction:) }

  let(:supplier_framework_ids) { %w[1 2 3] }
  let(:lot_id) { 'RM6360.1' }
  let(:service_ids) { %w[RM6360.1.1] }
  let(:not_core_jurisdiction) { nil }
  let(:jurisdiction_ids) { nil }

  describe 'validations' do
    context 'when no supplier frameworks are provided' do
      let(:supplier_framework_ids) { [] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:supplier_framework_ids].first).to eq 'You must select at least two suppliers for comparison'
      end
    end

    context 'when only one supplier framework is provided' do
      let(:supplier_framework_ids) { %w[1] }

      it 'is not valid and has the correct error message' do
        expect(step).not_to be_valid
        expect(step.errors[:supplier_framework_ids].first).to eq 'You must select at least two suppliers for comparison'
      end
    end

    context 'when a service is provided' do
      it 'is valid' do
        expect(step).to be_valid
      end
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::Suppliers' do
      expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::Suppliers
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, :not_core_jurisdiction, { service_ids: [], jurisdiction_ids: [], supplier_framework_ids: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id not_core_jurisdiction jurisdiction_ids service_ids supplier_framework_ids]
    end
  end

  describe '.slug' do
    it 'returns select-suppliers-for-comparison' do
      expect(step.slug).to eq 'select-suppliers-for-comparison'
    end
  end

  describe '.template' do
    it 'returns journey/select_suppliers_for_comparison' do
      expect(step.template).to eq 'journey/select_suppliers_for_comparison'
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

  describe '.supplier_frameworks' do
    let(:result) { step.suppliers_selector.supplier_frameworks }
    let(:supplier_frameworks) { instance_double(ActiveRecord::Relation) }

    before do
      allow(Supplier::Framework).to receive(:with_services_and_jurisdiction).with(service_ids, expected_jurisdiction_ids).and_return(supplier_frameworks)
      allow(supplier_frameworks).to receive(:includes).with(:supplier).and_return(supplier_frameworks)
      allow(supplier_frameworks).to receive(:order).with('supplier.name').and_return(supplier_frameworks)
    end

    %w[1 2 3 5].each do |lot_number|
      context "when the lot number is #{lot_number}" do
        let(:lot_id) { "RM6360.#{lot_number}" }
        let(:expected_jurisdiction_ids) { %w[GB] }

        it 'returns the supplier frameworks and calls supplier frameworks with a jurisdiction of GB' do
          expect(result).to eq(supplier_frameworks)
          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(%w[RM6360.1.1], %w[GB])
        end
      end
    end

    %w[4a 4b 4c].each do |lot_number|
      context "when the lot number is #{lot_number}" do
        let(:lot_id) { "RM6360.#{lot_number}" }

        context 'and not_core_jurisdiction is no' do
          let(:expected_jurisdiction_ids) { %w[GB] }
          let(:not_core_jurisdiction) { 'no' }

          it 'returns the supplier frameworks and calls supplier frameworks with a jurisdiction of GB' do
            expect(result).to eq(supplier_frameworks)
            expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(%w[RM6360.1.1], %w[GB])
          end
        end

        context 'and not_core_jurisdiction is yes' do
          let(:not_core_jurisdiction) { 'yes' }
          let(:jurisdiction_ids) { %w[AX TV] }
          let(:expected_jurisdiction_ids) { jurisdiction_ids }

          it 'returns the supplier frameworks and calls supplier frameworks with the passed jurisdiction ids' do
            expect(result).to eq(supplier_frameworks)
            expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(%w[RM6360.1.1], %w[AX TV])
          end
        end
      end
    end
  end
end
