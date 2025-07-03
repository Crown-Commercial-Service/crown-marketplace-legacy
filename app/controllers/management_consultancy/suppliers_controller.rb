module ManagementConsultancy
  class SuppliersController < ManagementConsultancy::FrameworkController
    before_action :fetch_supplier_frameworks, only: %i[index download]

    def index
      @journey = ManagementConsultancy::Journey.new(params[:framework], params[:slug], params)
      @back_path = @journey.previous_step_path
      @lot = Lot.find(params[:lot_id])
      @supplier_frameworks = Kaminari.paginate_array(@supplier_frameworks).page(params[:page])
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
          send_data spreadsheet.to_stream.read, filename: "shortlist_of_management_consultancy_suppliers_#{DateTime.now.getlocal.strftime '%d-%m-%Y'}.xlsx", type: :xlsx
        end
      end
    end

    private

    def service_name
      self.class.module_parent
    end

    def fetch_rates
      @supplier_framework.lots.find_by(lot_id: params[:lot_id], jurisdiction_id: 'GB').rates.index_by(&:position_id)
    end

    def fetch_supplier_frameworks
      @supplier_frameworks = Supplier::Framework.with_services_in_jurisdiction(params[:service_ids], 'GB').sort_by(&:supplier_name)
    end
  end
end
