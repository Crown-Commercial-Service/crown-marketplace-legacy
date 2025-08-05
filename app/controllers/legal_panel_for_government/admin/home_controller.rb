module LegalPanelForGovernment
  module Admin
    class HomeController < LegalPanelForGovernment::Admin::FrameworkController
      before_action :authenticate_user!, :authorize_user, :raise_if_unrecognised_framework, except: %i[framework index]

      def framework
        redirect_to legal_panel_for_government_admin_index_path(Framework.legal_panel_for_government.current_framework)
      end

      def index
        raise_if_unrecognised_framework
      end
    end
  end
end
