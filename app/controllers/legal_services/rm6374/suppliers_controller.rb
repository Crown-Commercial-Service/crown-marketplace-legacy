module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

      helper LegalServices::RM6374::RatesHelper

      before_action :fetch_supplier_framework, :fetch_rates, only: :show

      def download
        begin
          Search.log_results_downloaded_to_search(@lot.framework, current_user, session.id, params)
        rescue StandardError => e
          Rails.logger.error e
          Rollbar.log('error', e)
        end

        respond_to do |format|
          format.xlsx do
            spreadsheet_builder = SupplierSpreadsheetCreator.new(@supplier_frameworks, params)
            spreadsheet = spreadsheet_builder.build
            send_data spreadsheet.to_stream.read, filename: params[:call_off_mechanism].nil? ? 'Shortlist of Legal Services Suppliers.xlsx.xlsx' : 'Rates of Legal Services Suppliers.xlsx', type: :xlsx
          end
        end
      end

      def fetch_supplier_frameworks
        @supplier_frameworks = scoped_supplier_frameworks.shuffle
      end

      private

      def fetch_supplier_framework
        @supplier_framework = Supplier::Framework.joins(:supplier).find(params.expect(:id))
      end

      def fetch_rates
        @rates = @supplier_framework.grouped_rates_for_lot(@lot.id)
      end

      def scoped_supplier_frameworks
        if params[:lot_number] == '6'
          ::Supplier::Framework.with_lots(@lot.id).with_services(service_codes)
        elsif params[:lot_number] == '2' && params[:single_or_multiple_suppliers] == 'multiple'
          ::Supplier::Framework.with_any_services_and_jurisdiction(service_codes, [selected_jurisdiction_id])
        else
          ::Supplier::Framework.with_lots(@lot.id).with_services_and_jurisdiction(service_codes, [selected_jurisdiction_id])
        end
      end

      def service_codes
        params.expect(service_numbers: []).map { |num| "#{@lot.id}.#{num}" }
      end

      def selected_jurisdiction_id
        get_jurisdiction(params.expect(:jurisdiction))
      end

      def fetch_lot
        @lot = Lot.find("RM6374.#{params.expect(:lot_number)}")
      end
    end
  end
end
