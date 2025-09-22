module SupplyTeachers
  class Journey::FixedTermResults
    DATE_ATTIBUTES = %i[contract_start_date contract_end_date].freeze
    POSITION_ID = 'RM6238.1.11'.freeze

    include Steppable
    include Dateable
    include DateValidator
    include ActiveSupport::NumberHelper

    attribute :contract_start_date_day
    attribute :contract_start_date_month
    attribute :contract_start_date_year
    attribute :contract_end_date_day
    attribute :contract_end_date_month
    attribute :contract_end_date_year

    def fixed_term_length
      difference_in_months(contract_start_date, contract_end_date)
    end

    def determine_position_id
      self.class::POSITION_ID
    end

    def inputs
      {
        looking_for: translate_input('supply_teachers.looking_for.worker'),
        worker_type: translate_input('supply_teachers.worker_type.agency_supplied'),
        payroll_provider: translate_input('supply_teachers.payroll_provider.school'),
        postcode: postcode,
        radius: number_to_human(radius, units: :miles)
      }
    end
  end
end
