module ManagementConsultancy
  module RM6309
    class LotContactDetail < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :management_consultancy_rm6309_supplier_id,
                 inverse_of: :lot_contact_details

      validates :lot,
                presence: true,
                uniqueness: { scope: %i[supplier] },
                inclusion: { in: Lot.all_numbers }
    end
  end
end
