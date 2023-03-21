module LegalServices::Admin::FrameworkStatusConcern
  extend ActiveSupport::Concern

  included do
    before_action :raise_if_unrecognised_framework

    rescue_from ApplicationController::UnrecognisedFrameworkError do
      @unrecognised_framework = params[:framework]
      params[:framework] = Framework.legal_services.current_framework

      render 'legal_services/admin/home/unrecognised_framework', status: :bad_request
    end
  end

  protected

  def raise_if_unrecognised_framework
    raise ApplicationController::UnrecognisedFrameworkError, 'Unrecognised Framework' unless Framework.legal_services.recognised_framework? params[:framework]
  end
end
