require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6187::RateCard do
  subject(:rate_card) { build(:management_consultancy_rm6187_rate_card) }

  it { is_expected.to be_valid }
end
