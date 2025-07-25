module LegalPanelForGovernment
  module RM6360
    class SuppliersController < LegalPanelForGovernment::FrameworkController
      before_action :fetch_lot
      before_action :fetch_supplier_frameworks, only: %i[index download]
      before_action :fetch_supplier_framework, :fetch_rates, :fetch_jurisdictions, only: :show

      def index
        @journey = LegalPanelForGovernment::Journey.new(params[:framework], params[:slug], params)
        @back_path = @journey.previous_step_path
      end

      def show
        @back_path = :back
      end

      def download
        @back_path = :back

        respond_to do |format|
          format.html
          format.xlsx do
            spreadsheet_builder = SupplierSpreadsheetCreator.new(@supplier_frameworks, params)
            spreadsheet = spreadsheet_builder.build
            send_data spreadsheet.to_stream.read, filename: 'Shortlist of Legal Panel for Government Suppliers.xlsx', type: :xlsx
          end
        end
      end

      private

      def fetch_supplier_framework
        @supplier_framework = Supplier::Framework.joins(:supplier).find(params[:id])
      end

      def fetch_rates
        @rates = @supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, jurisdiction_ids)
      end

      def fetch_jurisdictions
        @jurisdictions = Jurisdiction.where(id: params[:jurisdiction_ids]).order(:name)
      end

      def fetch_supplier_frameworks
        @supplier_frameworks = Supplier::Framework.with_services_and_jurisdiction(params[:service_ids], jurisdiction_ids)
      end

      def fetch_lot
        @lot = Lot.find(params[:lot_id])
      end

      def jurisdiction_ids
        if @lot.id.starts_with?('RM6360.4') && params[:not_core_jurisdiction] == 'yes'
          params[:jurisdiction_ids]
        else
          ['GB']
        end
      end
    end
  end
end
