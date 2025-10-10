module SupplyTeachers
  class Journey::FTACalculatorContractStart
    DATE_ATTIBUTES = %i[contract_start_date].freeze

    include Steppable
    include DateValidations
    include ContractStartable

    def next_step_class
      service_name::Journey::FTACalculatorContractEnd
    end
  end
end
