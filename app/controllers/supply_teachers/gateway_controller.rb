module SupplyTeachers
  class GatewayController < SupplyTeachers::FrameworkController
    before_action :authenticate_user!, except: :index
    before_action :authorize_user, except: :index

    helper_method :new_user_session_path

    def index
      redirect_to supply_teachers_index_path(params[:framework]) if user_signed_in?
    end

    private

    def new_user_session_path
      "/supply-teachers/#{params[:framework]}/sign-in"
    end
  end
end
