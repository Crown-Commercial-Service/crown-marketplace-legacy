module LegalServices
  module RM3788
    class Journey::CheckSuitability
      include Steppable

      SUITABILITY_OPTIONS = %w[yes no].freeze

      attribute :service_suitable
      attribute :lot
      validates :service_suitable, inclusion: ['yes', 'no']

      def next_step_class
        case service_suitable
        when 'yes'
          Journey::ChooseServices
        when 'no'
          Journey::Sorry
        end
      end
    end
  end
end
