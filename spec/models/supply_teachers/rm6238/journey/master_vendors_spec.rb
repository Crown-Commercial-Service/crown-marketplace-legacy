require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::MasterVendors, type: :model do
  subject(:step) { described_class.new(managed_service_provider: 'master_vendor', threshold_position: 'above_threshold') }

  it { is_expected.to be_valid }

  describe '.final?' do
    it 'returns true' do
      expect(step.final?).to be true
    end
  end
end
