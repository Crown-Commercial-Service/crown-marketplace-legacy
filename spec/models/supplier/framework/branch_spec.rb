require 'rails_helper'

RSpec.describe Supplier::Framework::Branch do
  describe 'associations' do
    let(:supplier_framework_branch) { create(:supplier_framework_branch) }

    it { is_expected.to belong_to(:supplier_framework) }

    it 'has the supplier_framework relationship' do
      expect(supplier_framework_branch.supplier_framework).to be_present
    end
  end
end
