require 'rails_helper'

RSpec.describe SupplyTeachers::RM6238::Journey::TempToPermFee do
  subject(:step) { described_class.new }

  it 'is the final step' do
    expect(step.final?).to be true
  end
end
