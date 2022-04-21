class ActiveStorage::BlobsController < ActiveStorage::BaseController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :validate_service, except: :show
  include ActiveStorage::SetBlob

  rescue_from CanCan::AccessDenied do
    redirect_to not_permitted_path(service: params[:service])
  end

  def show
    expires_in ActiveStorage.service_urls_expire_in
    redirect_to @blob.service_url(disposition: params[:disposition])
  end

  protected

  def authorize_user
    if params[:st_upload_id].present?
      authorize_upload_view SupplyTeachers::Admin::Upload, params[:st_upload_id]
    elsif params[:mc_upload_id].present?
      authorize_upload_view ManagementConsultancy::RM6187::Admin::Upload, params[:mc_upload_id]
    elsif params[:ls_upload_id].present?
      authorize_upload_view LegalServices::Admin::Upload, params[:ls_upload_id]
    end
  end

  def authorize_upload_view(model, id)
    upload = model.find_by(id: id)

    raise ActionController::RoutingError, 'not found' if upload.blank?

    authorize! :view, upload if upload.present?
  end
end
