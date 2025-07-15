module LegalPanelForGovernment::Admin::FrameworkStatusConcern
  extend ActiveSupport::Concern

  included do
    before_action :raise_if_unrecognised_framework

    rescue_from ApplicationController::UnrecognisedFrameworkError do
      @unrecognised_framework = params[:framework]
      params[:framework] = Framework.legal_panel_for_government.current_framework

      render 'legal_panel_for_government/admin/home/unrecognised_framework', status: :bad_request
    end
  end

  protected

  def raise_if_unrecognised_framework
    raise ApplicationController::UnrecognisedFrameworkError, 'Unrecognised Framework' unless Framework.legal_panel_for_government.recognised_framework? params[:framework]
  end
end
