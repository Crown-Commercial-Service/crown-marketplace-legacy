module ManagementConsultancy
  module RM6187
    module Admin
      class UploadsController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::SharedPagesConcern
        include ::Admin::UploadsController

        private

        def upload_params
          params.require(:management_consultancy_rm6187_admin_upload).permit(:supplier_details_file, :supplier_rate_cards_file, :supplier_service_offerings_file) if params[:management_consultancy_rm6187_admin_upload].present?
        end
      end
    end
  end
end
