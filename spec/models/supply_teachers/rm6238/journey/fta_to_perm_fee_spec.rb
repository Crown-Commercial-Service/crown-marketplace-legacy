require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::FTAToPermFee, type: :model do
  subject(:step) { described_class.new }

  it { is_expected.to be_valid }

  describe '.final?' do
    it 'returns true' do
      expect(step.final?).to be true
    end
  end
end
