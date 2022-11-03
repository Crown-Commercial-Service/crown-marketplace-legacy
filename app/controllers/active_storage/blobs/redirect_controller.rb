class ActiveStorage::Blobs::RedirectController < ActiveStorage::BaseController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :validate_service, except: :show
  include ActiveStorage::SetBlob

  rescue_from CanCan::AccessDenied do
    redirect_to supply_teachers_rm6238_not_permitted_path
  end

  def show
    expires_in ActiveStorage.service_urls_expire_in
    redirect_to @blob.url(disposition: params[:disposition])
  end

  protected

  def authorize_user
    raise CanCan::AccessDenied unless params[:key] && params[:value] && KEY_TO_MODEL.key?(params[:key].to_sym)

    object = KEY_TO_MODEL[params[:key].to_sym].find_by(id: params[:value])

    raise ActionController::RoutingError, 'not found' if object.blank?

    authorize! :read, object if object.present?
  end

  KEY_TO_MODEL = {
    st_rm6238_upload_id: SupplyTeachers::RM6238::Admin::Upload,
    mc_rm6187_upload_id: ManagementConsultancy::RM6187::Admin::Upload,
    ls_rm6240_upload_id: LegalServices::RM6240::Admin::Upload
  }.freeze
end
