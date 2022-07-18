module SupplyTeachers
  module RM6238
    class Journey::ManagedServiceProvider
      include Steppable

      MANAGED_SERVICE_PROVIDERS = %w[master_vendor education_technology_platform].freeze

      attribute :managed_service_provider
      validates :managed_service_provider, inclusion: MANAGED_SERVICE_PROVIDERS

      def next_step_class
        case managed_service_provider
        when 'master_vendor'
          Journey::MasterVendorOptions
        when 'education_technology_platform'
          Journey::EducationTechnologyPlatformVendors
        end
      end
    end
  end
end
