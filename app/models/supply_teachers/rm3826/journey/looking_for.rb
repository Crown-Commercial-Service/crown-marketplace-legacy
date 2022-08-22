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

      def next_step_class
        case looking_for
        when 'worker'
          service_name::Journey::WorkerType
        when 'master_vendor'
          service_name::Journey::MasterVendors
        when 'calculate_temp_to_perm_fee'
          service_name::Journey::TempToPermCalculator
        when 'calculate_fta_to_perm_fee'
          service_name::Journey::FTAToPermContractStart
        when 'all_suppliers'
          service_name::Journey::AllSuppliers
        end
      end
    end
  end
end
