module LegalPanelForGovernment
  module RM6360
    class HomeController < LegalPanelForGovernment::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern

      skip_before_action :redirect_to_buyer_detail

      def index
        redirect_to legal_panel_for_government_rm6360_buyer_details_path if user_signed_in?
      end
    end
  end
end
