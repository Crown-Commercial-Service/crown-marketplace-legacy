module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

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

      private

      def fetch_supplier_frameworks
        service_codes = params.expect(service_numbers: []).map do |service_number|
          "#{@lot.id}.#{service_number}"
        end

        @supplier_frameworks = if params[:lot_number] == '6'
                                 ::Supplier::Framework.with_lots(@lot.id).with_services(service_codes)
                               else
                                 jurisdiction_id = get_jurisdiction(params.expect(:jurisdiction))
                                 ::Supplier::Framework.with_lots(@lot.id).with_services_and_jurisdiction(service_codes, [jurisdiction_id])
                               end.shuffle
      end

      def fetch_lot
        @lot = Lot.find("RM6374.#{params.expect(:lot_number)}")
      end
    end
  end
end
