module SupplyTeachers
  class Journey::LookingFor
    include Steppable

    attribute :looking_for

    def next_step_class
      case looking_for
      when 'worker'
        service_name::Journey::WorkerType
      when 'master_vendor'
        service_name::Journey::MasterVendors
      when 'managed_service_provider'
        service_name::Journey::ManagedServiceProvider
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
