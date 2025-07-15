module LegalPanelForGovernment::FrameworkStatusConcern
  extend ActiveSupport::Concern

  included do
    before_action :raise_if_not_live_framework

    rescue_from ApplicationController::UnrecognisedLiveFrameworkError do
      @unrecognised_framework = params[:framework]
      params[:framework] = Framework.legal_panel_for_government.current_framework

      render 'legal_panel_for_government/home/unrecognised_framework', status: :bad_request
    end
  end

  protected

  def raise_if_not_live_framework
    raise ApplicationController::UnrecognisedLiveFrameworkError, 'Unrecognised Live Framework' unless Framework.legal_panel_for_government.live_framework?(params[:framework])
  end
end
