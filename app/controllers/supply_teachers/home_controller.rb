module SupplyTeachers
  class HomeController < SupplyTeachers::FrameworkController
    before_action :authenticate_user!, :authorize_user, :redirect_if_not_live_framework, except: %i[framework index]

    def framework
      redirect_to supply_teachers_index_path(Framework.supply_teachers.current_framework)
    end

    def index
      redirect_if_not_live_framework
    end
  end
end
