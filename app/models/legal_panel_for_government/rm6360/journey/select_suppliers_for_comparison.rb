module LegalPanelForGovernment
  module RM6360
    class Journey::SelectSuppliersForComparison
      include Steppable

      attribute :lot_id
      attribute :not_core_jurisdiction
      attribute :jurisdiction_ids, Array
      attribute :service_ids, Array
      attribute :supplier_framework_ids, Array

      validates :supplier_framework_ids, length: { minimum: 2 }

      def lot
        @lot ||= Lot.find(lot_id)
      end

      def suppliers_selector
        @suppliers_selector ||= SuppliersSelector.new(lot_id:, service_ids:, not_core_jurisdiction:, jurisdiction_ids:)
      end

      def next_step_class
        Journey::Suppliers
      end
    end
  end
end
