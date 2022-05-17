module LegalServices
  module Admin
    class HomeController < LegalServices::Admin::FrameworkController
      before_action :authenticate_user!, :authorize_user, :raise_if_unrecognised_framework, except: %i[framework index]

      def framework
        redirect_to legal_services_admin_index_path(Framework.legal_services.current_framework)
      end

      def index
        raise_if_unrecognised_framework
      end
    end
  end
end
