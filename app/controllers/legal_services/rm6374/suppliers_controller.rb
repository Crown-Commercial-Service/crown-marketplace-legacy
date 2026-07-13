module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      private

      def fetch_rates
        @supplier_framework.grouped_rates_for_lot(@lot.id)
      end

      def fetch_supplier_frameworks
        service_codes = params.expect(service_numbers: []).map do |service_number|
          "#{@lot.id}.#{service_number}"
        end

        @supplier_frameworks = Supplier::Framework.with_services(service_codes).shuffle
      end

      def fetch_lot
        @lot = Lot.find("RM6374.#{params.expect(:lot_number)}")
      end
    end
  end
end
