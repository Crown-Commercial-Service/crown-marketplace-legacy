module LegalServices
  module RM6374
    class Journey::ChooseSpecialisms
      include Steppable

      SPECIALISM_OPTIONS = %w[full_service specific dispute_resolution risk_innovation transport_highways costs_service].freeze

      attribute :specialism
      validates :specialism, inclusion: SPECIALISM_OPTIONS

      def next_step_class
        case looking_for
        when 'full_service'
          service_name::Journey::FullService
        when 'specific'
          service_name::Journey::Specific
        when 'dispute_resolution'
          service_name::Journey::DisputeResolution
        when 'risk_innovation'
          service_name::Journey::RiskInnovation
        when 'transport_highways'
          service_name::Journey::TransportHighways
        end
        when 'costs_service'
          service_name::Journey::CostService
        end
      end
    end
  end
end
