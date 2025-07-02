module LegalServices
  module RM6240
    class SuppliersController < LegalServices::SuppliersController
      private

      def fetch_rates
        @supplier_framework.grouped_rates_for_lot_in_jurisdiction(params[:lot_id], params[:jurisdiction_id] || 'GB')
      end

      def fetch_supplier_frameworks
        @supplier_frameworks = Supplier::Framework.with_services_in_jurisdiction(
          *if params[:lot_id] == 'RM6240.3'
             [['RM6240.3.1'], 'GB']
           else
             [params[:service_ids], params[:jurisdiction_id]]
           end
        ).shuffle
      end
    end
  end
end
