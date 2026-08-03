module LegalServices
  module RM6374
    class SuppliersController < LegalServices::SuppliersController
      include LegalServices::RM6374

      helper LegalServices::RM6374::RatesHelper

      before_action :fetch_supplier_framework, :fetch_rates, only: :show

      def show
        # @back_path = legal_services_rm6374_suppliers_path(**@journey.params)
      end

      private

      def fetch_supplier_framework
        @supplier_framework = Supplier::Framework.joins(:supplier).find(params.expect(:id))
      end

      def fetch_rates
        @rates = @supplier_framework.grouped_rates_for_lot(@lot.id)
      end

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
