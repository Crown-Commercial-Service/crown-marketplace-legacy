require 'rails_helper'

RSpec.describe Supplier::Framework do
  describe 'associations' do
    let(:supplier_framework) { create(:supplier_framework) }

    it { is_expected.to belong_to(:supplier) }
    it { is_expected.to belong_to(:framework) }

    it { is_expected.to have_one(:contact_detail) }
    it { is_expected.to have_one(:address) }

    it { is_expected.to have_many(:lots) }
    it { is_expected.to have_many(:branches) }

    it 'has the supplier relationship' do
      expect(supplier_framework.supplier).to be_present
    end

    it 'has the framework relationship' do
      expect(supplier_framework.framework).to be_present
    end
  end

  describe 'uniqueness' do
    let(:supplier) { create(:supplier) }
    let(:framework) { create(:framework) }

    it 'raises an error if a record already exists for a supplier and framework' do
      create(:supplier_framework, supplier:, framework:)

      expect { create(:supplier_framework, supplier:, framework:) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe '.with_services_in_jurisdiction' do
    let(:result) { described_class.with_services_in_jurisdiction(service_ids, jurisdiction_id).pluck(:id) }
    let(:supplier_frameworks) { create_list(:supplier_framework, 4, framework_id: 'RM6240') }
    let(:supplier_framework_1_id) { supplier_frameworks[0].id }
    let(:supplier_framework_2_id) { supplier_frameworks[1].id }
    let(:jurisdiction_id) { 'GB-EW' }

    before do
      supplier_frameworks[2].update(enabled: false)

      supplier_framework_1_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[0], lot_id: 'RM6240.1', jurisdiction_id: 'GB-EW')
      supplier_framework_1_lot_b = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[0], lot_id: 'RM6240.1', jurisdiction_id: 'GB-SC')
      supplier_framework_2_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[1], lot_id: 'RM6240.1', jurisdiction_id: 'GB-EW')
      supplier_framework_2_lot_c = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[1], lot_id: 'RM6240.3', jurisdiction_id: 'GB')
      supplier_framework_3_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[2], lot_id: 'RM6240.1', jurisdiction_id: 'GB-EW')
      supplier_framework_3_lot_b = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[2], lot_id: 'RM6240.1', jurisdiction_id: 'GB-SC')
      supplier_framework_4_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[3], lot_id: 'RM6240.1', jurisdiction_id: 'GB-EW', enabled: false)
      supplier_framework_4_lot_c = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[3], lot_id: 'RM6240.3', jurisdiction_id: 'GB', enabled: false)

      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_1_lot_a, service_id: 'RM6240.1.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_2_lot_a, service_id: 'RM6240.1.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_3_lot_a, service_id: 'RM6240.1.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_4_lot_a, service_id: 'RM6240.1.1')

      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_1_lot_b, service_id: 'RM6240.1.2')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_2_lot_a, service_id: 'RM6240.1.2')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_3_lot_b, service_id: 'RM6240.1.2')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_4_lot_a, service_id: 'RM6240.1.2')

      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_2_lot_c, service_id: 'RM6240.3.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_4_lot_c, service_id: 'RM6240.3.1')
    end

    context 'when we pass a single service code' do
      let(:service_ids) { ['RM6240.1.1'] }

      it 'returns both suppliers' do
        expect(result).to contain_exactly(supplier_framework_1_id, supplier_framework_2_id)
      end
    end

    context 'when we pass multiple service codes' do
      let(:service_ids) { ['RM6240.1.1', 'RM6240.1.2'] }

      it 'returns the second supplier' do
        expect(result).to contain_exactly(supplier_framework_2_id)
      end
    end

    context 'when we pass service codes neither supplier does' do
      let(:service_ids) { ['RM6240.2.1'] }

      it 'returns an emoty array' do
        expect(result).to be_empty
      end
    end

    context 'when we pass 3.1 for the service' do
      let(:service_ids) { ['RM6240.3.1'] }
      let(:jurisdiction_id) { 'GB' }

      it 'returns the second supplier' do
        expect(result).to contain_exactly(supplier_framework_2_id)
      end
    end

    context 'when we pass a different jurisdiction' do
      let(:service_ids) { ['RM6240.1.2'] }
      let(:jurisdiction_id) { 'GB-SC' }

      it 'returns the first supplier' do
        expect(result).to contain_exactly(supplier_framework_1_id)
      end
    end
  end
end
