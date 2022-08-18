module SupplyTeachers
  module RM3826
    class Journey::LookingFor < SupplyTeachers::Journey::LookingFor
      LOOKING_FOR_OPTIONS = %w[
        worker
        master_vendor
        calculate_temp_to_perm_fee
        calculate_fta_to_perm_fee
        all_suppliers
      ].freeze

      validates :looking_for, inclusion: LOOKING_FOR_OPTIONS
    end
  end
end
