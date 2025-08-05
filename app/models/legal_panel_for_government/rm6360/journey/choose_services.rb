module LegalPanelForGovernment
  module RM6360
    class Journey::ChooseServices
      include Steppable

      attribute :lot_id
      attribute :service_ids, Array
      validates :service_ids, presence: true

      def lot_services
        Service.where(lot_id:).order(:name)
      end

      def lot
        Lot.find(lot_id)
      end

      def next_step_class
        Journey::Suppliers
      end
    end
  end
end
