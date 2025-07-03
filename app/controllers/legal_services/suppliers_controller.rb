module LegalServices
  class SuppliersController < LegalServices::FrameworkController
    before_action :fetch_supplier_frameworks, only: %i[index download]

    def index
      @journey = LegalServices::Journey.new(params[:framework], params[:slug], params)
      @back_path = @journey.previous_step_path
      @lot = Lot.find(params[:lot_id])
    end

    def show
      @back_path = :back
      @supplier_framework = Supplier::Framework.joins(:supplier).find(params[:id])
      @rates = fetch_rates
      @lot = Lot.find(params[:lot_id])
    end

    def download
      @back_path = :back

      respond_to do |format|
        format.html
        format.xlsx do
          spreadsheet_builder = service_name::SupplierSpreadsheetCreator.new(@supplier_frameworks, params)
          spreadsheet = spreadsheet_builder.build
          send_data spreadsheet.to_stream.read, filename: 'Shortlist of WPS Legal Services Suppliers.xlsx', type: :xlsx
        end
      end
    end

    private

    def service_name
      self.class.module_parent
    end
  end
end
