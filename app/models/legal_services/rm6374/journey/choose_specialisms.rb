module LegalServices
  module RM6374
    class Journey::ChooseSpecialisms
      include Steppable

      SPECIALISM_OPTIONS = %w[full_service specific dispute_resolution risk_innovation transport_highways costs_service].freeze

      attribute :specialism
      validates :specialism, inclusion: SPECIALISM_OPTIONS

      def next_step_class
        Journey::SelectLot
      end
    end
  end
end
