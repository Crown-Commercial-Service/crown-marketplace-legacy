module LegalPanelForGovernment
  module RM6360
    class SuppliersController < LegalPanelForGovernment::FrameworkController
      before_action :fetch_lot, :set_supplier_selector
      before_action :fetch_supplier_frameworks_with_rates, only: :index
      before_action :fetch_supplier_frameworks, only: :download
      before_action :fetch_supplier_framework, :fetch_rates, :fetch_jurisdictions, only: :show
      before_action :set_journey, :fetch_jurisdictions, only: %i[index show]

      def index
        @back_path = @journey.previous_step_path
      end

      def show
        @back_path = legal_panel_for_government_rm6360_suppliers_path(**@journey.params)
      end

      def download
        respond_to do |format|
          format.xlsx do
            spreadsheet_builder = SupplierSpreadsheetCreator.new(@supplier_frameworks, params)
            spreadsheet = spreadsheet_builder.build
            send_data spreadsheet.to_stream.read, filename: 'Shortlist of Legal Panel for Government Suppliers.xlsx', type: :xlsx
          end
        end
      end

      private

      def set_journey
        @journey = LegalPanelForGovernment::Journey.new(params[:framework], 'suppliers', params)
      end

      def fetch_lot
        @lot = Lot.find(params[:lot_id])
      end

      def set_supplier_selector
        @suppliers_selector = SuppliersSelector.new(lot_id: params[:lot_id], service_ids: params[:service_ids], not_core_jurisdiction: params[:not_core_jurisdiction], jurisdiction_ids: params[:jurisdiction_ids])
      end

      def fetch_supplier_frameworks
        @supplier_frameworks = @suppliers_selector.supplier_frameworks
      end

      def fetch_supplier_frameworks_with_rates
        @supplier_frameworks = if params[:have_you_reviewed] == 'no'
                                 @suppliers_selector.supplier_frameworks
                               else
                                 @suppliers_selector.supplier_frameworks.where(id: params[:supplier_framework_ids])
                               end.map { |supplier_framework| [supplier_framework, supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, @suppliers_selector.jurisdiction_ids)] }
      end

      def fetch_supplier_framework
        @supplier_framework = Supplier::Framework.joins(:supplier).find(params[:id])
      end

      def fetch_rates
        @rates = @supplier_framework.grouped_rates_for_lot_and_jurisdictions(@lot.id, @suppliers_selector.jurisdiction_ids)
      end

      def fetch_jurisdictions
        @jurisdictions = Jurisdiction.where(id: @suppliers_selector.jurisdiction_ids).order(:name)
      end
    end
  end
end
