module SupplyTeachers
  class HomeController < SupplyTeachers::FrameworkController
    before_action :authenticate_user!, :authorize_user, except: %i[framework index]
    before_action :raise_if_not_live_framework, except: :framework

    def framework
      redirect_to supply_teachers_index_path(Framework.supply_teachers.current_framework)
    end

    def index; end
  end
end
