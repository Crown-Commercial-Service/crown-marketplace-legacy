require 'rails_helper'

RSpec.describe Supplier do
  describe 'supplier' do
    context 'when default supplier from factory' do
      let(:supplier) { create(:supplier) }

      it 'is valid' do
        expect(supplier).to be_valid
      end
    end

    context 'when supplier from factory with duns number and sme nil' do
      let(:supplier) { create(:supplier, duns_number: nil, sme: nil) }

      it 'is valid' do
        expect(supplier).to be_valid
      end
    end

    context 'when multiple suppliers have a duns of nil' do
      it 'does not raise an error' do
        create(:supplier, duns_number: nil)

        expect { create(:supplier, duns_number: nil) }.not_to raise_error
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:supplier_frameworks) }

    context 'when a supplier framework is present' do
      let(:supplier) { create(:supplier, :with_supplier_frameworks) }

      it 'has the supplier_frameworks relationship' do
        expect(supplier.supplier_frameworks.count).to eq(2)
      end
    end
  end

  describe 'supplier validation' do
    let!(:default_supplier) { create(:supplier, :with_additional_details) }

    context 'when considering the supplier name' do
      let(:supplier) { build(:supplier, name:) }

      context 'and it is the same as another suppliers name' do
        let(:name) { default_supplier.name }

        it 'is not valid' do
          expect(supplier).not_to be_valid
          expect(supplier.errors[:name].first).to eq('The supplier name you entered is already in use by another supplier')
        end
      end
    end

    context 'when considering the supplier duns number' do
      let(:supplier) { build(:supplier, duns_number:) }

      context 'and it is the same as another suppliers duns number' do
        let(:duns_number) { default_supplier.duns_number }

        it 'is not valid' do
          expect(supplier).not_to be_valid
          expect(supplier.errors[:duns_number].first).to eq('The DUNS number you entered is already in use by another supplier')
        end
      end
    end

    context 'when considering the supplier trading name' do
      let(:supplier) { build(:supplier, trading_name:) }

      context 'and it is the same as another suppliers trading name' do
        let(:trading_name) { default_supplier.trading_name }

        it 'is not valid' do
          expect(supplier).not_to be_valid
          expect(supplier.errors[:trading_name].first).to eq('The supplier trading name you entered is already in use by another supplier')
        end
      end
    end

    context 'when considering the supplier additional identifier' do
      let(:supplier) { build(:supplier, additional_identifier:) }

      context 'and it is the same as another suppliers additional identifier' do
        let(:additional_identifier) { default_supplier.additional_identifier }

        it 'is not valid' do
          expect(supplier).not_to be_valid
          expect(supplier.errors[:additional_identifier].first).to eq('The additional identifier you entered is already in use by another supplier')
        end
      end
    end
  end
end
