module LegalPanelForGovernment
  module RM6360
    class Journey::InformationAboutYourRequirement
      DATE_ATTIBUTES = %i[requirement_start_date requirement_end_date].freeze

      include Steppable
      include DateValidations

      CCS_CAN_CONTACT_YOU_OPTIONS = %w[yes no].freeze

      attribute :requirement_start_date_day
      attribute :requirement_start_date_month
      attribute :requirement_start_date_year
      attribute :requirement_end_date_day
      attribute :requirement_end_date_month
      attribute :requirement_end_date_year
      attribute :requirement_estimated_total_value, Numeric
      attribute :ccs_can_contact_you

      validates :requirement_start_date, presence: true
      validate  -> { ensure_date_valid(:requirement_start_date, false) }

      validates :requirement_end_date, presence: true
      validate  -> { ensure_date_valid(:requirement_end_date, false) }
      validate -> { ensure_date_is_after(requirement_end_date, requirement_start_date, :requirement_end_date, :after_requirement_start_date) }

      validates :requirement_estimated_total_value, numericality: { only_integer: true, greater_than: 0, less_than: 1_000_000_000_000 }

      validates :ccs_can_contact_you, inclusion: CCS_CAN_CONTACT_YOU_OPTIONS

      def initialize(...)
        super

        @requirement_start_date_day = '1'
        @requirement_end_date_day = '1'
      end

      def next_step_class
        Journey::SelectLot
      end
    end
  end
end
