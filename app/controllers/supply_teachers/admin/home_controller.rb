module SupplyTeachers
  module Admin
    class HomeController < SupplyTeachers::Admin::FrameworkController
      before_action :authenticate_user!, :authorize_user, :raise_if_unrecognised_framework, except: %i[framework index]

      def framework
        redirect_to supply_teachers_admin_index_path(Framework.supply_teachers.current_framework)
      end

      def index
        raise_if_unrecognised_framework
      end
    end
  end
end
