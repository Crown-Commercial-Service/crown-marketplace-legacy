require 'rails_helper'

RSpec.describe Lot do
  describe 'associations' do
    let(:lot) { create(:lot) }

    it { is_expected.to belong_to(:framework) }
    it { is_expected.to have_many(:services) }
    it { is_expected.to have_many(:supplier_framework_lots) }

    it 'has the framework relationship' do
      expect(lot.framework).to be_present
    end
  end
end
