module SupplyTeachers
  class Journey::FTAToPermContractStart
    DATE_ATTIBUTES = %i[contract_start_date].freeze

    include Steppable
    include DateValidator
    include ContractStartable

    def next_step_class
      service_name::Journey::FTAToPermContractEnd
    end
  end
end
