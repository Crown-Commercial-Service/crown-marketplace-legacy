module SupplyTeachers
  module RM6376
    class Journey::LookingFor < SupplyTeachers::Journey::LookingFor
      LOOKING_FOR_OPTIONS = %w[
        all_suppliers
        worker
        managed_service_providers
        calculate_temp_to_perm_fee
        calculate_fta_to_perm_fee
      ].freeze

      validates :looking_for, inclusion: LOOKING_FOR_OPTIONS

      def next_step_class
        case looking_for
        when 'all_suppliers'
          service_name::Journey::AllSuppliers
        when 'worker'
          service_name::Journey::WorkerType
        when 'managed_service_providers'
          service_name::Journey::ManagedServiceProviders
        when 'calculate_temp_to_perm_fee'
          service_name::Journey::TempToPermCalculator
        when 'calculate_fta_to_perm_fee'
          service_name::Journey::FTAToPermContractStart
        end
      end
    end
  end
end
