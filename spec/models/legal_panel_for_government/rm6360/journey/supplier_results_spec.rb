require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::SupplierResults do
  subject(:step) { described_class.new(service_ids:, lot_id:) }

  let(:lot_id) { 'RM6360.1' }
  let(:service_ids) { %w[RM6360.1.1] }

  describe 'validations' do
    it 'is valid' do
      expect(step).to be_valid
    end
  end

  describe '.next_step_class' do
    it 'returns Journey::HaveYouReviewed' do
      expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::HaveYouReviewed
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [:lot_id, :not_core_jurisdiction, { jurisdiction_ids: [], service_ids: [] }]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq %i[lot_id service_ids not_core_jurisdiction jurisdiction_ids]
    end
  end

  describe '.slug' do
    it 'returns supplier-results' do
      expect(step.slug).to eq 'supplier-results'
    end
  end

  describe '.template' do
    it 'returns journey/supplier_results' do
      expect(step.template).to eq 'journey/supplier_results'
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

  describe '.suppliers_selector' do
    it 'sets the supplier selector' do
      expect(step.suppliers_selector.class).to eq(LegalPanelForGovernment::RM6360::SuppliersSelector)
    end
  end
end
