module SupplyTeachers
  module RM6238
    class ManagedServiceProvider < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :supply_teachers_rm6238_supplier_id,
                 inverse_of: :branches
    end
  end
end
