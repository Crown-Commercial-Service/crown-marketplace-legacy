require 'rails_helper'

RSpec.describe LegalPanelForGovernment::RM6360::Journey::Suppliers do
  subject(:step) { described_class.new }

  it { is_expected.to be_valid }

  describe '.next_step_class' do
    it 'returns Journey::SelectSuppliersForComparison' do
      expect(step.next_step_class).to be LegalPanelForGovernment::RM6360::Journey::SelectSuppliersForComparison
    end
  end

  describe '.permit_list' do
    it 'returns a list of the permitted attributes' do
      expect(described_class.permit_list).to eq [{}]
    end
  end

  describe '.permitted_keys' do
    it 'returns a list of the permitted keys' do
      expect(described_class.permitted_keys).to eq []
    end
  end

  describe '.slug' do
    it 'returns suppliers' do
      expect(step.slug).to eq 'suppliers'
    end
  end

  describe '.final?' do
    it 'returns false' do
      expect(step.final?).to be false
    end
  end
end
