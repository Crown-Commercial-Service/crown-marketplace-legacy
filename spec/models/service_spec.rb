require 'rails_helper'

RSpec.describe Service do
  it { is_expected.to belong_to(:lot) }
end
