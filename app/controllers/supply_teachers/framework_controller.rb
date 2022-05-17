module SupplyTeachers
  class FrameworkController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user
    before_action :redirect_if_not_live_framework

    protected

    def authorize_user
      authorize! :read, SupplyTeachers
    end

    def redirect_if_not_live_framework
      redirect_to supply_teachers_path unless Framework.supply_teachers.current_live_framework?(params[:framework])
    end
  end
end
