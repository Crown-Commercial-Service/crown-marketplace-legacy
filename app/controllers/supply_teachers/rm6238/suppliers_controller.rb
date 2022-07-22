module SupplyTeachers
  module RM6238
    class SuppliersController < SupplyTeachers::SuppliersController
      before_action :set_end_of_journey, only: %i[master_vendors]

      helper_method :threshold_position

      def master_vendors
        @back_path = source_journey.previous_step_path
        @suppliers = Supplier.with_master_vendor_rates(threshold_position)
      end

      def education_technology_platform_vendors
        @back_path = source_journey.previous_step_path
        @suppliers = Supplier.with_education_technology_platforms_rates
      end

      private

      def threshold_position
        @threshold_position ||= managed_service_provider_params[:threshold_position].to_sym
      end

      def source_journey
        SupplyTeachers::Journey.new(params[:framework], action_name, managed_service_provider_params)
      end

      def managed_service_provider_params
        params.permit(:looking_for, :managed_service_provider, :threshold_position)
      end
    end
  end
end
