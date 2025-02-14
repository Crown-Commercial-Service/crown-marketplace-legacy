module ManagementConsultancy
  module RM6309
    class RateCard < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :management_consultancy_rm6309_supplier_id,
                 inverse_of: :rate_cards

      validates :lot,
                presence: true,
                uniqueness: { scope: %i[supplier rate_type] },
                inclusion: { in: Lot.all_numbers }
    end
  end
end
