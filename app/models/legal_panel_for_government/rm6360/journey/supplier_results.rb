module LegalPanelForGovernment
  module RM6360
    class Journey::SupplierResults
      include Steppable

      attribute :lot_id
      attribute :service_ids, Array
      attribute :not_core_jurisdiction
      attribute :jurisdiction_ids, Array

      def lot
        @lot ||= Lot.find(lot_id)
      end

      def suppliers_selector
        @suppliers_selector ||= SuppliersSelector.new(lot_id:, service_ids:, not_core_jurisdiction:, jurisdiction_ids:)
      end

      def next_step_class
        Journey::HaveYouReviewed
      end
    end
  end
end
