module ManagementConsultancy
  class HomeController < ManagementConsultancy::FrameworkController
    before_action :authenticate_user!, :authorize_user, except: %i[framework index]
    before_action :raise_if_not_live_framework, except: :framework

    def framework
      redirect_to management_consultancy_index_path(Framework.management_consultancy.current_framework)
    end

    def index; end
  end
end
