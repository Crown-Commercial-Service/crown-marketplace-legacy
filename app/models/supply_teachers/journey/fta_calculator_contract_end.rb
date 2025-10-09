module SupplyTeachers
  class Journey::FTACalculatorContractEnd < GenericJourney
    DATE_ATTIBUTES = %i[contract_start_date contract_end_date].freeze

    include Steppable
    include DateValidations

    attribute :contract_start_date_day
    attribute :contract_start_date_month
    attribute :contract_start_date_year
    attribute :contract_end_date_day
    attribute :contract_end_date_month
    attribute :contract_end_date_year
    validates :contract_end_date, presence: true
    validate  -> { ensure_date_valid(:contract_end_date, false) }
    validate -> { ensure_date_is_after(contract_end_date, contract_start_date, :contract_end_date, :after_contract_start_date) }

    def next_step_class
      service_name::Journey::FTACalculatorSalary
    end

    def all_keys_needed?
      true
    end
  end
end
