module ManagementConsultancy
  module RM6309
    class SuppliersController < ManagementConsultancy::FrameworkController
      helper :telephone_number
      before_action :redirect_if_wrong_lot
      before_action :fetch_suppliers, only: %i[index download]
      before_action :set_back_path

      def index
        @journey = ManagementConsultancy::Journey.new(params[:framework], params[:slug], params)
        @back_path = @journey.previous_step_path
        @lot = Lot.find_by(number: params[:lot])
        @suppliers = Kaminari.paginate_array(@all_suppliers).page(params[:page])
      end

      def show
        @supplier = Supplier.find(params[:id])
        @lot = Lot.find_by(number: params[:lot])
        @rate_cards = if params[:lot] == 'MCF4.10'
                        RATE_TYPES[:'MCF4.10']
                      else
                        RATE_TYPES[:default]
                      end.index_with do |rate_type|
                        @supplier.rate_cards.where(lot: params[:lot], rate_type: rate_type).first
                      end
        @lot_contact_detail = @supplier.lot_contact_details.where(lot: params[:lot]).first
      end

      def download
        respond_to do |format|
          format.html
          format.xlsx do
            spreadsheet_builder = SupplierSpreadsheetCreator.new(@all_suppliers, params)
            spreadsheet = spreadsheet_builder.build
            send_data spreadsheet.to_stream.read, filename: "shortlist_of_management_consultancy_suppliers_#{DateTime.now.getlocal.strftime '%d-%m-%Y'}.xlsx", type: :xlsx
          end
        end
      end

      private

      def redirect_if_wrong_lot
        redirect_to management_consultancy_rm6309_path unless params[:lot].starts_with?('MCF4')
      end

      def fetch_suppliers
        @all_suppliers = Supplier.offering_services(
          params[:lot],
          params[:services],
        ).order(:name)
      end

      def set_back_path
        @back_path = :back
      end

      RATE_TYPES = {
        default: ['Advice', 'Delivery'],
        'MCF4.10': ['Complex', 'Non-Complex']
      }.freeze
    end
  end
end
