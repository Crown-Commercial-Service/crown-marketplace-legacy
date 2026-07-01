module LegalServices
  module RM6374
    module Admin
      class UploadsController < LegalServices::Admin::FrameworkController
        include ::Admin::UploadActions

        private

        def service_key
          :ls
        end

        def upload_params
          params.expect(
            legal_services_rm6374_admin_upload: %i[supplier_details_file
                                                   supplier_geographical_data_file
                                                   supplier_rate_cards_file]
          )
        end
      end
    end
  end
end
