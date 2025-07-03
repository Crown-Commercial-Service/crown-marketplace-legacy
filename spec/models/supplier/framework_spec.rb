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
end
