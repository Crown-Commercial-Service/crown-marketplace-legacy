module LegalPanelForGovernment
  module RM6360
    class Journey::CoreJurisdiction
      include Steppable

      CORE_JURISDICTIONS_OPTIONS = %w[yes no].freeze

      attribute :lot_id
      attribute :not_core_jurisdiction

      validates :not_core_jurisdiction, inclusion: CORE_JURISDICTIONS_OPTIONS

      def lot
        Lot.find(lot_id)
      end

      def next_step_class
        if not_core_jurisdiction == 'yes'
          Journey::ChooseJurisdiction
        else
          Journey::ChooseServices
        end
      end
    end
  end
end
