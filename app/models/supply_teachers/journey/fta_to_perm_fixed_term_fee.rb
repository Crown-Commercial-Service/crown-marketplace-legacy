module SupplyTeachers
  class Journey::FTAToPermFixedTermFee
    DATE_ATTIBUTES = %i[contract_start_date contract_end_date].freeze

    include Steppable
    include Dateable
    include DateValidator

    attribute :fixed_term_fee
    attribute :contract_start_date_day
    attribute :contract_start_date_month
    attribute :contract_start_date_year
    attribute :contract_end_date_day
    attribute :contract_end_date_month
    attribute :contract_end_date_year
    validates :fixed_term_fee, presence: true, numericality: { greater_than: 0 }

    def next_step_class
      service_name::Journey::FTAToPermFee
    end

    def all_keys_needed?
      true
    end

    def current_contract_length
      return unless contract_start_date && contract_end_date

      difference_in_months(contract_start_date, contract_end_date)
    end

    def hire_by_date
      contract_end_date + 6.months
    end
  end
end
