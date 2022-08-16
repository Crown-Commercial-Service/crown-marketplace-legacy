module LegalServices
  class FrameworkController < ::ApplicationController
    before_action :raise_if_not_live_framework
    before_action :authenticate_user!
    before_action :authorize_user

    rescue_from UnrecognisedLiveFrameworkError do
      @unrecognised_framework = params[:framework]
      params[:framework] = Framework.legal_services.current_framework

      render 'legal_services/home/unrecognised_framework', status: :bad_request
    end

    protected

    def authorize_user
      authorize! :read, LegalServices
    end

    def raise_if_not_live_framework
      raise UnrecognisedLiveFrameworkError, 'Unrecognised Live Framework' unless Framework.legal_services.live_framework?(params[:framework])
    end
  end
end
