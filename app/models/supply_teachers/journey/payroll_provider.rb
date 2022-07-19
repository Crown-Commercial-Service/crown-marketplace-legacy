module SupplyTeachers
  class Journey::PayrollProvider
    include Steppable

    PAYROLL_PROVIDERS = %w[agency school].freeze

    attribute :payroll_provider
    validates :payroll_provider, inclusion: PAYROLL_PROVIDERS

    def next_step_class
      case payroll_provider
      when 'school'
        service_name::Journey::FTACalculatorContractStart
      when 'agency'
        service_name::Journey::AgencyPayroll
      end
    end
  end
end
