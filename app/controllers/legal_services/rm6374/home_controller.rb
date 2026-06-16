module LegalServices
  module RM6374
    class HomeController < LegalServices::RM6374::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern

      skip_before_action :redirect_to_buyer_detail

      def index
        redirect_to legal_services_rm6374_buyer_details_path if user_signed_in?
      end
    end
  end
end
