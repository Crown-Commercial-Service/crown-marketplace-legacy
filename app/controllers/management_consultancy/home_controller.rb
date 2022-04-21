module ManagementConsultancy
  class HomeController < ManagementConsultancy::FrameworkController
    before_action :authenticate_user!, :authorize_user, :redirect_if_not_live_framework, except: %i[framework index]

    def framework
      redirect_to management_consultancy_index_path(Framework.management_consultancy.current_framework)
    end

    def index
      redirect_if_not_live_framework
    end
  end
end
