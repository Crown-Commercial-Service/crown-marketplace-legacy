module ManagementConsultancy
  module Admin
    class UploadsController < ManagementConsultancy::FrameworkController
      include ::Admin::SharedPagesConcern
      include ::Admin::UploadsController

      private

      def upload_params
        params.require(:management_consultancy_admin_upload).permit(:supplier_details_file, :supplier_rate_cards_file, :supplier_regional_offerings_file, :supplier_service_offerings_file) if params[:management_consultancy_admin_upload].present?
      end
    end
  end
end
