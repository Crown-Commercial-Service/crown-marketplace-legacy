module LegalPanelForGovernment
  module RM6360
    class SuppliersComparisonController < LegalPanelForGovernment::FrameworkController
      include SuppliersConcern

      before_action :fetch_supplier_frameworks_with_rates, :fetch_jurisdictions

      def index
        @journey = LegalPanelForGovernment::Journey.new(params[:framework], params[:slug], params)
        @back_path = @journey.previous_step_path
      end

      private

      def fetch_supplier_frameworks_with_rates
        @supplier_frameworks = Supplier::Framework.with_services_and_jurisdiction(params[:service_ids], jurisdiction_ids)
                                                  .where(id: params[:supplier_framework_ids])
                                                  .order('supplier.name')
                                                  .map { |supplier_framework| [supplier_framework, supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, jurisdiction_ids)] }
      end
    end
  end
end
