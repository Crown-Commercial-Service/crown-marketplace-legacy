require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::EducationTechnologyPlatformVendors, type: :model do
  subject(:step) { described_class.new(managed_service_provider: 'education_technology_platform') }

  it { is_expected.to be_valid }

  describe '.final?' do
    it 'returns true' do
      expect(step.final?).to be true
    end
  end
end
