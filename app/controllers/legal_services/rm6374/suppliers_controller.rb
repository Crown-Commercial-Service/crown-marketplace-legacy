module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

      private

      def fetch_supplier_frameworks
        service_codes = params.expect(service_numbers: []).map do |service_number|
          "#{@lot.id}.#{service_number}"
        end

        @supplier_frameworks = if params[:lot_number] == '6'
                                 ::Supplier::Framework.with_lots(@lot.id).with_services(service_codes)
                               else
                                 jurisdiction_id = get_jurisdiction(params.expect(:jurisdiction))
                                 ::Supplier::Framework.with_lots(@lot.id).with_services_and_jurisdiction(service_codes, [jurisdiction_id])
                               end.shuffle
      end

      def fetch_lot
        @lot = Lot.find("RM6374.#{params.expect(:lot_number)}")
      end
    end
  end
end
