module SupplyTeachers::FrameworkStatusConcern
  extend ActiveSupport::Concern

  included do
    before_action :raise_if_not_live_framework

    rescue_from ApplicationController::UnrecognisedLiveFrameworkError do
      @unrecognised_framework = params[:framework]
      params[:framework] = Framework.supply_teachers.current_framework

      render 'supply_teachers/home/unrecognised_framework', status: :bad_request
    end
  end

  protected

  def raise_if_not_live_framework
    raise ApplicationController::UnrecognisedLiveFrameworkError, 'Unrecognised Live Framework' unless Framework.supply_teachers.live_framework?(params[:framework])
  end
end
