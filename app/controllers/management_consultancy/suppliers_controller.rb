module ManagementConsultancy
  class SuppliersController < ManagementConsultancy::FrameworkController
    helper :telephone_number
    before_action :redirect_if_wrong_lot
    before_action :fetch_suppliers, only: %i[index download]
    before_action :set_back_path

    def index
      @journey = Journey.new(params[:slug], params)
      @back_path = @journey.previous_step_path
      @lot = Lot.find_by(number: params[:lot])
      @suppliers = Kaminari.paginate_array(@all_suppliers).page(params[:page])
    end

    def show
      @supplier = Supplier.find(params[:id])
      @lot = Lot.find_by(number: params[:lot])
      @rate_card = @supplier.rate_cards.where(lot: params[:lot]).first
    end

    def download
      respond_to do |format|
        format.html
        format.xlsx do
          spreadsheet_builder = ManagementConsultancy::SupplierSpreadsheetCreator.new(@all_suppliers, params)
          spreadsheet = spreadsheet_builder.build
          render xlsx: spreadsheet.to_stream.read, filename: "shortlist_of_management_consultancy_suppliers.xlsx_#{DateTime.now.getlocal.strftime '%d-%m-%Y'}", format: 'application/vnd.openxmlformates-officedocument.spreadsheetml.sheet'
        end
      end
    end

    private

    def redirect_if_wrong_lot
      if Marketplace.mcf3_live?
        redirect_to management_consultancy_path unless params[:lot].starts_with?('MCF3')
      elsif ['MCF1', 'MCF2'].none? { |lot| params[:lot].starts_with?(lot) }
        redirect_to management_consultancy_path
      end
    end

    def fetch_suppliers
      @all_suppliers = if Marketplace.mcf3_live?
                         Supplier.offering_services(
                           params[:lot],
                           params[:services],
                         ).order(:name)
                       else
                         Supplier.offering_services_in_regions(
                           params[:lot],
                           params[:services],
                           params[:region_codes]
                         ).order(:name)
                       end
    end

    def set_back_path
      @back_path = :back
    end
  end
end
