require 'rails_helper'

RSpec.describe Supplier::Framework do
  let(:supplier_framework) { create(:supplier_framework) }

  describe 'associations' do
    it { is_expected.to belong_to(:supplier) }
    it { is_expected.to belong_to(:framework) }

    it { is_expected.to have_one(:contact_detail) }
    it { is_expected.to have_one(:address) }

    it { is_expected.to have_many(:lots) }

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

  describe '.grouped_rates_for_lot' do
    let(:result) { supplier_framework.grouped_rates_for_lot(lot_id) }
    let(:lot_id) { 'RM6240.1a' }
    let(:supplier_framework_lot_a) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: 'RM6240.1a') }
    let(:supplier_framework_lot_c) { create(:supplier_framework_lot, supplier_framework: supplier_framework, lot_id: 'RM6240.3') }

    let!(:lot_a_grouped_rates) do
      {
        1 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_a, position_id: 1),
        2 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_a, position_id: 2),
        3 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_a, position_id: 3),
        4 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_a, position_id: 4),
      }
    end
    let!(:lot_c_grouped_rates) do
      {
        1 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_c, position_id: 1),
        2 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_c, position_id: 2),
        3 => create(:supplier_framework_lot_rate, supplier_framework_lot: supplier_framework_lot_c, position_id: 3),
      }
    end

    context 'when we pass the lot and jursidiction' do
      let(:lot_id) { 'RM6240.1a' }

      it 'returns the 4 grouped rates' do
        expect(result).to eq(lot_a_grouped_rates)
      end
    end

    context 'when we pass a lot with no rates' do
      let(:lot_id) { 'RM6240.2a' }

      it 'raises no method error' do
        expect { result }.to raise_error(NoMethodError)
      end
    end

    context 'when we pass 3 for the lot' do
      let(:lot_id) { 'RM6240.3' }

      it 'returns the 3 grouped rates' do
        expect(result).to eq(lot_c_grouped_rates)
      end
    end
  end

  describe '.with_lots' do
    let(:result) { described_class.with_lots(lot_id).pluck(:id) }
    let(:supplier_frameworks) { create_list(:supplier_framework, 4, framework_id: 'RM6240') }
    let(:supplier_framework_1_id) { supplier_frameworks[0].id }
    let(:supplier_framework_2_id) { supplier_frameworks[1].id }

    before do
      supplier_frameworks[2].update(enabled: false)

      create(:supplier_framework_lot, supplier_framework: supplier_frameworks[0], lot_id: 'RM6240.1a')
      create(:supplier_framework_lot, supplier_framework: supplier_frameworks[1], lot_id: 'RM6240.1a')
      create(:supplier_framework_lot, supplier_framework: supplier_frameworks[1], lot_id: 'RM6240.3')
      create(:supplier_framework_lot, supplier_framework: supplier_frameworks[2], lot_id: 'RM6240.1a')
      create(:supplier_framework_lot, supplier_framework: supplier_frameworks[3], lot_id: 'RM6240.1a', enabled: false)
      create(:supplier_framework_lot, supplier_framework: supplier_frameworks[3], lot_id: 'RM6240.3', enabled: false)
    end

    context 'when we pass the lot id' do
      let(:lot_id) { 'RM6240.1a' }

      it 'returns both suppliers' do
        expect(result).to contain_exactly(supplier_framework_1_id, supplier_framework_2_id)
      end
    end

    context 'when we pass a lot id neither supplier does' do
      let(:lot_id) { 'RM6240.2a' }

      it 'returns an emoty array' do
        expect(result).to be_empty
      end
    end

    context 'when we pass 3 for the lot id' do
      let(:lot_id) { 'RM6240.3' }

      it 'returns the second supplier' do
        expect(result).to contain_exactly(supplier_framework_2_id)
      end
    end
  end

  describe '.with_services' do
    let(:result) { described_class.with_services(service_ids).pluck(:id) }
    let(:supplier_frameworks) { create_list(:supplier_framework, 5, framework_id: 'RM6240') }
    let(:supplier_framework_1_id) { supplier_frameworks[0].id }
    let(:supplier_framework_2_id) { supplier_frameworks[1].id }

    before do
      supplier_frameworks[2].update(enabled: false)

      supplier_framework_1_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[0], lot_id: 'RM6240.1a')
      supplier_framework_2_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[1], lot_id: 'RM6240.1a')
      supplier_framework_2_lot_c = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[1], lot_id: 'RM6240.3')
      supplier_framework_3_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[2], lot_id: 'RM6240.1a')
      supplier_framework_4_lot_a = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[3], lot_id: 'RM6240.1a', enabled: false)
      supplier_framework_4_lot_c = create(:supplier_framework_lot, supplier_framework: supplier_frameworks[3], lot_id: 'RM6240.3', enabled: false)

      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_1_lot_a, service_id: 'RM6240.1a.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_2_lot_a, service_id: 'RM6240.1a.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_3_lot_a, service_id: 'RM6240.1a.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_4_lot_a, service_id: 'RM6240.1a.1')

      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_2_lot_a, service_id: 'RM6240.1a.2')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_3_lot_a, service_id: 'RM6240.1a.2')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_4_lot_a, service_id: 'RM6240.1a.2')

      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_2_lot_c, service_id: 'RM6240.3.1')
      create(:supplier_framework_lot_service, supplier_framework_lot: supplier_framework_4_lot_c, service_id: 'RM6240.3.1')
    end

    context 'when we pass a single service code' do
      let(:service_ids) { ['RM6240.1a.1'] }

      it 'returns both suppliers' do
        expect(result).to contain_exactly(supplier_framework_1_id, supplier_framework_2_id)
      end
    end

    context 'when we pass multiple service codes' do
      let(:service_ids) { ['RM6240.1a.1', 'RM6240.1a.2'] }

      it 'returns the second supplier' do
        expect(result).to contain_exactly(supplier_framework_2_id)
      end
    end

    context 'when we pass service codes neither supplier does' do
      let(:service_ids) { ['RM6240.2a.1'] }

      it 'returns an emoty array' do
        expect(result).to be_empty
      end
    end

    context 'when we pass 3.1 for the service' do
      let(:service_ids) { ['RM6240.3.1'] }

      it 'returns the second supplier' do
        expect(result).to contain_exactly(supplier_framework_2_id)
      end
    end
  end
end
