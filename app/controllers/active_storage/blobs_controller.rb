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
      authorize_supply_teachers_upload_view
    elsif params[:mc_upload_id].present?
      authorize_management_consultancy_upload_view
    elsif params[:ls_upload_id].present?
      authorize_legal_services_upload_view
    end
  end

  def authorize_supply_teachers_upload_view
    st_upload = SupplyTeachers::Admin::Upload.find_by(id: params[:st_upload_id])

    raise ActionController::RoutingError, 'not found' if st_upload.blank?

    authorize! :view, st_upload if st_upload.present?
  end

  def authorize_management_consultancy_upload_view
    mc_upload = ManagementConsultancy::Admin::Upload.find_by(id: params[:mc_upload_id])

    raise ActionController::RoutingError, 'not found' if mc_upload.blank?

    authorize! :view, mc_upload if mc_upload.present?
  end

  def authorize_legal_services_upload_view
    ls_upload = LegalServices::Admin::Upload.find_by(id: params[:ls_upload_id])

    raise ActionController::RoutingError, 'not found' if ls_upload.blank?

    authorize! :view, ls_upload if ls_upload.present?
  end
end
