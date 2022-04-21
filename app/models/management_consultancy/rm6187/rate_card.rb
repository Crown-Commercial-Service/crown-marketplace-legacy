module ManagementConsultancy
  module RM6187
    class RateCard < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :management_consultancy_rm6187_supplier_id,
                 inverse_of: :rate_cards
    end
  end
end
