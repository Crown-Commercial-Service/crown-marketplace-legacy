module SupplyTeachers
  module RM6238
    class Journey::LookingFor
      include Steppable

      LOOKING_FOR_OPTIONS = %w[
        worker
        managed_service_provider
        calculate_temp_to_perm_fee
        calculate_fta_to_perm_fee
        all_suppliers
      ].freeze

      attribute :looking_for
      validates :looking_for, inclusion: LOOKING_FOR_OPTIONS

      def next_step_class
        case looking_for
        when 'worker'
          Journey::WorkerType
        when 'managed_service_provider'
          Journey::ManagedServiceProvider
        when 'calculate_temp_to_perm_fee'
          Journey::TempToPermCalculator
        when 'calculate_fta_to_perm_fee'
          Journey::FTAToPermContractStart
        when 'all_suppliers'
          Journey::AllSuppliers
        end
      end
    end
  end
end
