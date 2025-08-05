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
        Lot.find(lot_id)
      end

      def supplier_frameworks
        Supplier::Framework.with_services_and_jurisdiction(service_ids, determine_jurisdiction_ids).order('supplier.name')
      end

      def next_step_class
        Journey::SuppliersComparison
      end

      private

      def determine_jurisdiction_ids
        if lot_id.starts_with?('RM6360.4') && not_core_jurisdiction == 'yes'
          jurisdiction_ids
        else
          ['GB']
        end
      end
    end
  end
end
