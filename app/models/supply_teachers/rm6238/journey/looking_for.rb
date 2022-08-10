module SupplyTeachers
  module RM6238
    class Journey::LookingFor < SupplyTeachers::Journey::LookingFor
      LOOKING_FOR_OPTIONS = %w[
        worker
        managed_service_provider
        calculate_temp_to_perm_fee
        calculate_fta_to_perm_fee
        all_suppliers
      ].freeze

      validates :looking_for, inclusion: LOOKING_FOR_OPTIONS
    end
  end
end
