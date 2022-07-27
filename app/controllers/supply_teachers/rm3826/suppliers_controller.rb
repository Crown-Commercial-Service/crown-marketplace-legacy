module SupplyTeachers
  module RM3826
    class SuppliersController < SupplyTeachers::SuppliersController
      before_action :set_end_of_journey, only: %i[master_vendors neutral_vendors]

      def master_vendors
        @back_path = source_journey.previous_step_path
        @suppliers = Supplier.with_master_vendor_rates
      end

      def neutral_vendors
        @back_path = source_journey.current_step_path
        @suppliers = Supplier.with_neutral_vendor_rates
      end

      private

      def source_journey
        SupplyTeachers::Journey.new(params[:framework], 'managed-service-provider', managed_service_provider_params)
      end

      def managed_service_provider_params
        params.permit(:looking_for, :managed_service_provider)
      end
    end
  end
end
