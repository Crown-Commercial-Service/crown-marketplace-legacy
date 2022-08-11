module LegalServices
  module RM3788
    class SuppliersController < LegalServices::SuppliersController
      private

      def fetch_rate_card
        @supplier.rate_cards.select { |rate_card| rate_card['lot'] == lot_rate_card_number }.first
      end

      def lot_rate_card_number
        return params[:lot] unless params[:lot] == '2'

        params[:lot] + params[:jurisdiction]
      end

      def fetch_suppliers
        @suppliers = Supplier.offering_services_in_regions(
          params[:lot],
          params[:services],
          params[:jurisdiction],
          params[:region_codes]
        ).shuffle
      end
    end
  end
end
