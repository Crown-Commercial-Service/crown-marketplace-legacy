module ManagementConsultancy
  module Admin
    class HomeController < ManagementConsultancy::Admin::FrameworkController
      before_action :authenticate_user!, :authorize_user, :raise_if_unrecognised_framework, except: %i[framework index]

      def framework
        redirect_to management_consultancy_admin_index_path(Framework.management_consultancy.current_framework)
      end

      def index
        raise_if_unrecognised_framework
      end
    end
  end
end
