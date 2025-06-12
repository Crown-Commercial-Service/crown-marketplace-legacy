module ManagementConsultancy
  module RM6309
    module Admin
      class UploadsController < ManagementConsultancy::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::UploadsController

        private

        def upload_params
          params.expect(management_consultancy_rm6309_admin_upload: %i[supplier_details_file supplier_rate_cards_file supplier_service_offerings_file]) if params[:management_consultancy_rm6309_admin_upload].present?
        end
      end
    end
  end
end
