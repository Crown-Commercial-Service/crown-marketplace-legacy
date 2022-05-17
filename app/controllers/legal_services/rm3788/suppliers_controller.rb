module LegalServices
  module RM3788
    class SuppliersController < LegalServices::FrameworkController
      before_action :fetch_suppliers, only: %i[index download]

      def index
        @journey = LegalServices::Journey.new(params[:framework], params[:slug], params)
        @back_path = @journey.previous_step_path
        @lot = Lot.find_by(number: params[:lot])
      end

      def show
        @back_path = :back
        @supplier = Supplier.find(params[:id])
        @rate_card = @supplier.rate_cards.select { |rate_card| rate_card['lot'] == lot_rate_card_number }.first
        @lot = Lot.find_by(number: params[:lot])
      end

      def download
        @back_path = :back

        respond_to do |format|
          format.html
          format.xlsx do
            spreadsheet_builder = LegalServices::RM3788::SupplierSpreadsheetCreator.new(@suppliers, params)
            spreadsheet = spreadsheet_builder.build
            send_data spreadsheet.to_stream.read, filename: 'Shortlist of WPS Legal Services Suppliers.xlsx', type: :xlsx
          end
        end
      end

      private

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
