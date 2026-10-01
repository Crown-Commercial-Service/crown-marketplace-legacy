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
          params.expect(legal_services_rm6374_admin_upload: %i[supplier_details_file supplier_lot_1a_service_offerings_file supplier_lot_1b_service_offerings_file supplier_lot_1c_service_offerings_file supplier_lot_2_service_offerings_file supplier_lot_3_service_offerings_file supplier_lot_4_service_offerings_file supplier_lot_5_service_offerings_file supplier_lot_6_service_offerings_file supplier_rate_cards_file]) if params[:legal_services_rm6374_admin_upload].present?
        end
      end
    end
  end
end
