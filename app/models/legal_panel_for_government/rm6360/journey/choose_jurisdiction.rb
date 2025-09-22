module LegalPanelForGovernment
  module RM6360
    class Journey::ChooseJurisdiction
      include Steppable

      attribute :lot_id
      attribute :jurisdiction_ids, Array

      validates :jurisdiction_ids, length: { minimum: 1 }

      def non_core_jurisdictions
        Jurisdiction.non_core.order(:name)
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
