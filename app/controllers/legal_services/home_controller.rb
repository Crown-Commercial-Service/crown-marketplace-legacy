module LegalServices
  class HomeController < LegalServices::FrameworkController
    before_action :authenticate_user!, :authorize_user, except: %i[framework index]
    before_action :raise_if_not_live_framework, except: :framework

    def framework
      redirect_to legal_services_index_path(Framework.legal_services.current_framework)
    end

    def index; end
  end
end
