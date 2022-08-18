module ManagementConsultancy
  class FrameworkController < ::ApplicationController
    before_action :raise_if_not_live_framework
    before_action :authenticate_user!
    before_action :authorize_user

    rescue_from UnrecognisedLiveFrameworkError do
      @unrecognised_framework = params[:framework]
      params[:framework] = Framework.management_consultancy.current_framework

      render 'management_consultancy/home/unrecognised_framework', status: :bad_request
    end

    protected

    def authorize_user
      authorize! :read, ManagementConsultancy
    end

    def raise_if_not_live_framework
      raise UnrecognisedLiveFrameworkError, 'Unrecognised Live Framework' unless Framework.management_consultancy.live_framework?(params[:framework])
    end
  end
end
