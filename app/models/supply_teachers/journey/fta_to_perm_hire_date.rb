module SupplyTeachers
  class Journey::FTAToPermHireDate
    DATE_ATTIBUTES = %i[contract_end_date hire_date].freeze

    include Steppable
    include Dateable
    include DateValidations

    attribute :contract_end_date_day
    attribute :contract_end_date_month
    attribute :contract_end_date_year
    attribute :hire_date_day
    attribute :hire_date_month
    attribute :hire_date_year
    attribute :no_fee_reason
    validates :hire_date, presence: true
    validate  -> { ensure_date_valid(:hire_date, false) }
    validate -> { ensure_date_is_after(hire_date, contract_end_date, :hire_date, :after_contract_end_date) }

    def next_step_class
      if hire_date && hire_date_within_6_months_of_contract_end
        service_name::Journey::FTAToPermHireDateNotice
      else
        @no_fee_reason = 'hire_not_within_6_months'
        service_name::Journey::FTAToPermFee
      end
    end

    def all_keys_needed?
      true
    end

    def hire_by_date
      contract_end_date + 6.months
    end

    private

    def hire_date_within_6_months_of_contract_end
      return unless hire_date && contract_end_date

      difference_in_months(contract_end_date, hire_date) < 6
    end
  end
end
