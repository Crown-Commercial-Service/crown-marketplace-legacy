module LegalPanelForGovernment
  class HomeController < LegalPanelForGovernment::FrameworkController
    before_action :authenticate_user!, :authorize_user, except: %i[framework index]
    before_action :raise_if_not_live_framework, except: :framework

    def framework
      redirect_to legal_panel_for_government_index_path(Framework.legal_panel_for_government.current_framework)
    end

    def index; end
  end
end
