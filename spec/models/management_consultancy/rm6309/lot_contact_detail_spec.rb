require 'rails_helper'

RSpec.describe ManagementConsultancy::RM6309::LotContactDetail do
  subject(:lot_contact_detail) { build(:management_consultancy_rm6309_lot_contact_detail) }

  it { is_expected.to be_valid }
end
