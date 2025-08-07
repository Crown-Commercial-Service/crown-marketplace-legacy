module LegalPanelForGovernment
  module RM6360
    module Admin
      class UploadsController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::UploadsController

        private

        def upload_params
          params.expect(legal_panel_for_government_rm6360_admin_upload: %i[supplier_details_file supplier_service_offerings_file supplier_other_lots_rate_cards_file supplier_lot_4a_rate_cards_file supplier_lot_4b_rate_cards_file supplier_lot_4c_rate_cards_file]) if params[:legal_panel_for_government_rm6360_admin_upload].present?
        end
      end
    end
  end
end
