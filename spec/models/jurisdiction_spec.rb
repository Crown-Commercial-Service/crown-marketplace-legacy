require 'rails_helper'

RSpec.describe Jurisdiction do
  describe 'associations' do
    let(:jurisdiction) { described_class.first }

    it { is_expected.to have_many(:supplier_framework_lots) }
  end

  it 'has all the jurisdictions loaded' do
    expect(described_class.count).to eq(198)
  end
end
