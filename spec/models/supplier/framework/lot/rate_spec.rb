require 'rails_helper'

RSpec.describe Supplier::Framework::Lot::Rate do
  describe 'associations' do
    let(:supplier_framework_lot_rate) { create(:supplier_framework_lot_rate) }

    it { is_expected.to belong_to(:supplier_framework_lot) }
    it { is_expected.to belong_to(:position) }

    it 'has the supplier_framework_lot relationship' do
      expect(supplier_framework_lot_rate.supplier_framework_lot).to be_present
    end

    it 'has the position relationship' do
      expect(supplier_framework_lot_rate.position).to be_present
    end
  end

  describe 'uniqueness' do
    let(:supplier_framework_lot) { create(:supplier_framework_lot) }
    let(:position) { create(:position) }

    it 'raises an error if a record already exists for a supplier_framework_lot and position' do
      create(:supplier_framework_lot_rate, supplier_framework_lot:, position:)

      expect { create(:supplier_framework_lot_rate, supplier_framework_lot:, position:) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
