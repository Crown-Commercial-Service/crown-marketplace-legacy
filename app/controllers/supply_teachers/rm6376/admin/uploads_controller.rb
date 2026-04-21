module SupplyTeachers
  module RM6376
    module Admin
      class UploadsController < SupplyTeachers::Admin::FrameworkController
        include ::Admin::UploadsController

        private

        def upload_params
          params.expect(supply_teachers_rm6376_admin_upload: %i[supplier_details_file supplier_geographical_data_file supplier_rate_cards_file]) if params[:supply_teachers_rm6376_admin_upload].present?
        end
      end
    end
  end
end
