module SupplyTeachers
  module RM6238
    class SuppliersController < SupplyTeachers::SuppliersController
      before_action :set_end_of_journey, only: %i[master_vendors]

      def master_vendors
        @lot_id = managed_service_provider_params[:threshold_position] == 'above_threshold' ? 'RM6238.2.2' : 'RM6238.2.1'
        @back_path = source_journey.previous_step_path
        @supplier_frameworks = ::Supplier::Framework.with_lots(@lot_id).sort_by(&:supplier_name)
      end

      def education_technology_platform_vendors
        @lot_id = 'RM6238.4'
        @back_path = source_journey.previous_step_path
        @supplier_frameworks = ::Supplier::Framework.with_lots(@lot_id).sort_by(&:supplier_name)
      end

      private

      def source_journey
        SupplyTeachers::Journey.new(params[:framework], action_name, managed_service_provider_params)
      end

      def managed_service_provider_params
        params.permit(:looking_for, :managed_service_provider, :threshold_position)
      end

      def set_lot_for_all_suppliers
        @lot_id = 'RM6238.1'
      end
    end
  end
end
