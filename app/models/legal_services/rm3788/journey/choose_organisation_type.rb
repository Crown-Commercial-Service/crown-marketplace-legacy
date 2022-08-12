module LegalServices
  module RM3788
    class Journey::ChooseOrganisationType
      include Steppable

      CENTRAL_GOVERNMENT_OPTIONS = %w[yes no].freeze

      attribute :central_government
      validates :central_government, inclusion: CENTRAL_GOVERNMENT_OPTIONS

      def next_step_class
        case central_government
        when 'yes'
          Journey::CheckSuitability
        else
          Journey::SelectLot
        end
      end
    end
  end
end
