class ActiveStorage::BlobsController < ActiveStorage::BaseController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :validate_service, except: :show
  include ActiveStorage::SetBlob

  rescue_from CanCan::AccessDenied do
    redirect_to supply_teachers_rm3826_not_permitted_path
  end

  def show
    expires_in ActiveStorage.service_urls_expire_in
    redirect_to @blob.service_url(disposition: params[:disposition])
  end

  protected

  def authorize_user
    raise CanCan::AccessDenied unless params[:key] && params[:value] && KEY_TO_MODEL.key?(params[:key].to_sym)

    object = KEY_TO_MODEL[params[:key].to_sym].find_by(id: params[:value])

    raise ActionController::RoutingError, 'not found' if object.blank?

    authorize! :view, object if object.present?
  end

  KEY_TO_MODEL = {
    st_upload_id: SupplyTeachers::RM3826::Admin::Upload,
    mc_upload_id: ManagementConsultancy::RM6187::Admin::Upload,
    ls_upload_id: LegalServices::RM3788::Admin::Upload
  }.freeze
end
