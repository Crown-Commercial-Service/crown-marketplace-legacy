module SupplyTeachers
  module RM6376
    class SuppliersController < SupplyTeachers::SuppliersController
      before_action :set_end_of_journey, only: %i[managed_service_provider]

      def managed_service_provider
        @lot_id = 'RM6376.2'
        set_lot
        @back_path = source_journey.previous_step_path
        @supplier_frameworks = ::Supplier::Framework.with_lots(@lot_id).sort_by(&:supplier_name)
      end

      private

      def source_journey
        SupplyTeachers::Journey.new(params[:framework], action_name, managed_service_provider_params)
      end

      def managed_service_provider_params
        params.permit(:looking_for)
      end

      def set_lot_for_all_suppliers
        @lot_id = 'RM6376.1'
      end

      def set_lot
        @lot = Lot.find(@lot_id)
      end
    end
  end
end
