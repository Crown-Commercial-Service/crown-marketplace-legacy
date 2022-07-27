module LegalServices
  module RM6240
    module Admin
      class UploadsController < LegalServices::Admin::UploadsController
        private

        def upload_params
          params.require(:legal_services_rm6240_admin_upload).permit(:supplier_details_file, :supplier_rate_cards_file, :supplier_lot_1_service_offerings_file, :supplier_lot_2_service_offerings_file, :supplier_lot_3_service_offerings_file) if params[:legal_services_rm6240_admin_upload].present?
        end
      end
    end
  end
end
