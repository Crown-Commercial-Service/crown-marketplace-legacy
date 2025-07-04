module LegalServices
  module RM6240
    class SuppliersController < LegalServices::SuppliersController
      private

      def fetch_rates
        @supplier_framework.lots.find_by(lot_id: params[:lot_id], jurisdiction_id: params[:jurisdiction_id] || 'GB').rates.index_by(&:position_id)
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
