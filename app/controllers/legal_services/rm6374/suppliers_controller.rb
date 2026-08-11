module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

      helper LegalServices::RM6374::RatesHelper
      helper_method :fetch_services_from_supplier_framework_for_lot_2

      before_action :fetch_supplier_framework, :fetch_rates, only: :show

      def index
        fetch_supplier_frameworks

        @journey = LegalServices::Journey.new(params[:framework], params[:slug], params)
        begin
          Search.log_new_search(@lot.framework, current_user, session.id, @journey.params.to_hash, @supplier_frameworks)
        rescue StandardError => e
          Rollbar.log('error', e)
        end

        return unless params[:framework].to_s.casecmp?('rm6374') && @lot&.number.to_s == '2'

        render 'lot_2_interim_result_page'
      end

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

      def download_rm6374_lot_2_rate
        filename = 'lot_2_rate.xlsx'

        file_path = if Rails.env.local?
                      Rails.root.join('app', 'controllers', 'legal_services', 'rm6374', filename)
                    else
                      temp_path = Rails.root.join('tmp', filename)
                      s3_client.get_object(
                        bucket: ENV.fetch('LOT2_RATE_BUCKET', nil),
                        key: filename,
                        response_target: temp_path.to_s
                      )
                      temp_path
                    end

        send_file(
          file_path,
          filename: filename,
          type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          disposition: 'attachment'
        )
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

      def fetch_services_from_supplier_framework_for_lot_2(supplier_framework)
        framework_lot = supplier_framework.lots.find { |l| l.lot_id == @lot.id }

        selected_codes = service_codes.map { |code| code.start_with?('RM6374.') ? code : "RM6374.#{code}" }

        framework_lot.services
                     .select { |s| selected_codes.include?(s.service_id) }
                     .map { |s| s.service.name }
      end

      def selected_jurisdiction_id
        get_jurisdiction(params.expect(:jurisdiction))
      end

      def fetch_lot
        @lot = Lot.find("RM6374.#{params.expect(:lot_number)}")
      end

      def s3_client
        @s3_client ||= Aws::S3::Client.new(region: 'eu-west-2')
      end
    end
  end
end
