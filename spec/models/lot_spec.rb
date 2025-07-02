require 'rails_helper'

RSpec.describe Lot do
  it { is_expected.to belong_to(:framework) }
  it { is_expected.to have_many(:services) }
end
