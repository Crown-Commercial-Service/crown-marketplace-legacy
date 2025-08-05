module LegalServices
  module RM6240
    class SuppliersController < LegalServices::SuppliersController
      private

      def fetch_rates
        @supplier_framework.grouped_rates_for_lot(@lot.id)
      end

      def fetch_supplier_frameworks
        @supplier_frameworks = Supplier::Framework.with_services(
          if @lot.id == 'RM6240.3'
            ['RM6240.3.1']
          else
            params[:service_numbers].map { |service_number| "#{@lot.id}.#{service_number}" }
          end
        ).shuffle
      end

      def fetch_lot
        @lot = Lot.find("RM6240.#{params[:lot_number]}#{params[:jurisdiction]}")
      end
    end
  end
end
