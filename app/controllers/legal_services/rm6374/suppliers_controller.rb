module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

      private

      def fetch_supplier_frameworks
        service_codes = params.expect(service_numbers: []).map do |service_number|
          "#{@lot.id}.#{service_number}"
        end

        selected_jurisdiction_id = get_jurisdiction(params.expect(:jurisdiction))

        @supplier_frameworks = ::Supplier::Framework.with_lots(@lot.id)
                                                    .with_services_and_jurisdiction(service_codes, [selected_jurisdiction_id]).shuffle
      end

      def fetch_lot
        @lot = Lot.find("RM6374.#{params.expect(:lot_number)}")
      end
    end
  end
end
