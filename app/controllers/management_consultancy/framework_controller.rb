module ManagementConsultancy
  class FrameworkController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user
    before_action :redirect_if_not_live_framework

    protected

    def authorize_user
      authorize! :read, ManagementConsultancy
    end

    def redirect_if_not_live_framework
      redirect_to management_consultancy_path unless Framework.management_consultancy.current_live_framework?(params[:framework])
    end
  end
end
