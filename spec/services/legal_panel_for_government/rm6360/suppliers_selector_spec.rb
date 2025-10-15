require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::SuppliersSelector do
  let(:suppliers_selector) { described_class.new(lot_id:, service_ids:, not_core_jurisdiction:, jurisdiction_ids:) }

  let(:supplier_framework) { create(:supplier_framework) }
  let(:supplier_frameworks) { Supplier::Framework.where(id: supplier_framework.id).includes(:supplier).order('supplier.name') }

  let(:lot_id) { 'RM6360.1' }
  let(:lot) { Lot.find(lot_id) }
  let(:services) { Service.where(lot_id:).sample(5) }
  let(:service_ids) { services.map(&:id) }
  let(:not_core_jurisdiction) { nil }
  let(:jurisdiction_ids) { nil }

  let(:expected_jurisdiction_ids) { ['GB'] }

  describe '.initialize' do
    let(:jurisdiction_ids) { ['AE', 'AX'] }
    let(:not_core_jurisdiction) { 'yes' }

    it 'sets service_ids' do
      expect(suppliers_selector.service_ids).to eq(service_ids)
    end

    it 'sets jurisdiction_ids' do
      expect(suppliers_selector.jurisdiction_ids).to eq(expected_jurisdiction_ids)
    end
  end

  describe '.supplier_frameworks' do
    let(:result) { suppliers_selector.supplier_frameworks }

    before { allow(Supplier::Framework).to receive(:with_services_and_jurisdiction).with(service_ids, expected_jurisdiction_ids).and_return(supplier_frameworks) }

    it 'sets jurisdiction_ids' do
      expect(suppliers_selector.jurisdiction_ids).to eq(expected_jurisdiction_ids)
    end

    it 'returns the supplier frameworks' do
      expect(result).to eq supplier_frameworks
    end

    context 'when the lot is 1a' do
      it 'calls the database with GB' do
        result

        expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, expected_jurisdiction_ids)
      end
    end

    context 'when the lot is 4a' do
      let(:lot_id) { 'RM6360.4a' }

      context 'and not_core_jurisdiction is no' do
        let(:not_core_jurisdiction) { 'no' }

        it 'sets jurisdiction_ids' do
          expect(suppliers_selector.jurisdiction_ids).to eq(expected_jurisdiction_ids)
        end

        it 'calls the database with GB' do
          result

          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, expected_jurisdiction_ids)
        end
      end

      context 'and not_core_jurisdiction is yes' do
        let(:jurisdiction_ids) { ['AE', 'AX'] }
        let(:not_core_jurisdiction) { 'yes' }
        let(:expected_jurisdiction_ids) { jurisdiction_ids }

        it 'sets jurisdiction_ids' do
          expect(suppliers_selector.jurisdiction_ids).to eq(expected_jurisdiction_ids)
        end

        it 'calls the database with AE and AX' do
          result

          expect(Supplier::Framework).to have_received(:with_services_and_jurisdiction).with(service_ids, expected_jurisdiction_ids)
        end
      end
    end
  end
end
