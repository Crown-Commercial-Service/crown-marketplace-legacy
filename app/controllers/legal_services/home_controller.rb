module LegalServices
  class HomeController < LegalServices::FrameworkController
    before_action :authenticate_user!, :authorize_user, :redirect_if_not_live_framework, except: %i[framework index]

    def framework
      redirect_to legal_services_index_path(Framework.legal_services.current_framework)
    end

    def index
      redirect_if_not_live_framework
    end
  end
end
