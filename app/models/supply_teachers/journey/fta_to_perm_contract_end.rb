module SupplyTeachers
  class Journey::FTAToPermContractEnd < GenericJourney
    DATE_ATTIBUTES = %i[contract_start_date contract_end_date].freeze

    include Steppable
    include Dateable
    include DateValidator

    attribute :contract_start_date_day
    attribute :contract_start_date_month
    attribute :contract_start_date_year
    attribute :contract_end_date_day
    attribute :contract_end_date_month
    attribute :contract_end_date_year
    attribute :no_fee_reason
    validates :contract_end_date, presence: true
    validate  -> { ensure_date_valid(:contract_end_date, false) }
    validate -> { ensure_date_is_after(contract_end_date, contract_start_date, :contract_end_date, :after_contract_start_date) }

    def next_step_class
      if contract_end_date && contract_end_within_6_months && contract_length_within_12_months
        service_name::Journey::FTAToPermHireDate
      else
        @no_fee_reason = contract_end_within_6_months ? 'length_not_within_12_months' : 'end_not_within_6_months'
        service_name::Journey::FTAToPermFee
      end
    end

    def all_keys_needed?
      true
    end

    private

    def contract_end_within_6_months
      return unless contract_end_date

      today = Time.zone.today
      difference_in_months(contract_end_date, today) <= 6
    end

    def contract_length_within_12_months
      return unless contract_end_date && contract_start_date

      difference_in_months(contract_start_date, contract_end_date) < 12
    end
  end
end
