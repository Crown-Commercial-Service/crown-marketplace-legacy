module LegalServices
  module RM6240
    class SuppliersController < LegalServices::SuppliersController
      private

      def fetch_rate_card
        @supplier.rate_card(params[:lot], params[:jurisdiction])
      end

      def fetch_suppliers
        @suppliers = Supplier.offering_services_in_jurisdiction(
          params[:lot],
          params[:services],
          params[:jurisdiction]
        ).shuffle
      end
    end
  end
end
