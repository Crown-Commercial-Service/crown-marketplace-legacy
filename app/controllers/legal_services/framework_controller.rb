module LegalServices
  class FrameworkController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user
    before_action :redirect_if_not_live_framework

    protected

    def authorize_user
      authorize! :read, LegalServices
    end

    def redirect_if_not_live_framework
      redirect_to legal_services_path unless Framework.legal_services.current_live_framework?(params[:framework])
    end
  end
end
