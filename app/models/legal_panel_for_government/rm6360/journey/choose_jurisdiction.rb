module LegalPanelForGovernment
  module RM6360
    class Journey::ChooseJurisdiction
      include Steppable

      CORE_JURISDICTIONS = %w[GB BE CH DE FR IE US CA].freeze

      attribute :lot_id
      attribute :jurisdiction_ids, Array

      validates :jurisdiction_ids, length: { minimum: 1 }

      def non_core_jurisdictions
        Jurisdiction.where.not(id: CORE_JURISDICTIONS).order(:name)
      end

      def lot
        Lot.find(lot_id)
      end

      def next_step_class
        Journey::ChooseServices
      end
    end
  end
end
