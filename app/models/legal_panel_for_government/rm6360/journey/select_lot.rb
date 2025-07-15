module LegalPanelForGovernment
  module RM6360
    class Journey::SelectLot
      include Steppable

      attribute :lot_id
      validates :lot_id, presence: true

      def self.lots
        Lot.where(framework_id: framework).order('lots.number')
      end

      def next_step_class
        case lot_id
        when 'RM6360.1', 'RM6360.2', 'RM6360.3', 'RM6360.5'
          Journey::ChooseServices
        else
          Journey::CoreJurisdiction
        end
      end
    end
  end
end
