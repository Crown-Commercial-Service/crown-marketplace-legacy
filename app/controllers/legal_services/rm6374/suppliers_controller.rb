module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

      helper LegalServices::RM6374::RatesHelper
      helper LegalServices::RM6374::Admin::SuppliersHelper
      helper_method :fetch_services_with_suppliers_for_lot_2

      before_action :fetch_supplier_framework, :fetch_rates, only: :show

      def index
        fetch_supplier_frameworks

        @journey = LegalServices::Journey.new(params[:framework], params[:slug], params)
        begin
          Search.log_new_search(@lot.framework, current_user, session.id, @journey.params.to_hash, @supplier_frameworks)
        rescue StandardError => e
          Rollbar.log('error', e)
        end
      end

      def download
        begin
          Search.log_results_downloaded_to_search(current_user, session.id)
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

      def fetch_services_with_suppliers_for_lot_2
        selected_codes = service_codes.map { |code| code.start_with?('RM6374.') ? code : "RM6374.#{code}" }
        services_with_supplier_frameworks = Hash.new { |hash, key| hash[key] = [] }

        scoped_supplier_frameworks.each do |supplier_framework|
          extract_matching_services(supplier_framework, selected_codes).each do |service|
            key = [service.service.id, service.service.name]
            services_with_supplier_frameworks[key] << supplier_framework
          end
        end

        services_with_supplier_frameworks.transform_values { |frameworks| frameworks.uniq(&:id) }
      end

      private

      def fetch_supplier_framework
        @supplier_framework = Supplier::Framework.joins(:supplier).find(params.expect(:id))
      end

      def fetch_rates
        @rates = if params[:lot_number] == '2' && params[:single_or_multiple_suppliers] == 'single'
                   @supplier_framework.grouped_rates_for_lot_and_jurisdictions_and_services(@lot.id, [selected_jurisdiction_id], service_codes)
                 elsif params[:lot_number] == '2' && params[:single_or_multiple_suppliers] == 'multiple'
                   @supplier_framework.grouped_rates_for_lot_and_jurisdictions_and_services(@lot.id, [selected_jurisdiction_id], params.expect(:service_id)).values.first
                 else
                   @supplier_framework.grouped_rates_for_lot(@lot.id)
                 end
      end

      def scoped_supplier_frameworks # rubocop:disable Metrics/AbcSize
        selected_sector_id = helpers.sector_id_for(params.expect(:sector).to_sym)

        if params[:lot_number] == '6'
          ::Supplier::Framework.with_lots(@lot.id).with_services(service_codes).with_sector(selected_sector_id)
        elsif params[:lot_number] == '2' && params[:single_or_multiple_suppliers] == 'multiple'
          ::Supplier::Framework.with_any_services_and_jurisdiction(service_codes, [selected_jurisdiction_id]).with_sector(selected_sector_id)
        else
          ::Supplier::Framework.with_lots(@lot.id).with_services_and_jurisdiction(service_codes, [selected_jurisdiction_id]).with_sector(selected_sector_id)
        end
      end

      def service_codes
        params.expect(service_numbers: []).map { |num| "#{@lot.id}.#{num}" }
      end

      def extract_matching_services(supplier_framework, selected_codes)
        framework_lot = supplier_framework.lots.find { |l| l.lot_id == @lot.id }
        return [] unless framework_lot

        framework_lot.services.select { |s| selected_codes.include?(s.service_id) }
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
