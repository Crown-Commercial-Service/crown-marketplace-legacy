module Admin::UploadsController
  extend ActiveSupport::Concern

  included do
    skip_before_action :verify_authenticity_token, only: :create
    before_action :authenticate_user!
    before_action :authorize_user
    before_action :set_upload, only: %i[show progress]
  end

  def index
    @latest_upload = service::Admin::Upload.latest_upload
    @uploads = service::Admin::Upload.all.page params[:page]
  end

  def show; end

  def new
    @upload = service::Admin::Upload.new
  end

  def create
    @upload = service::Admin::Upload.new(upload_params)

    if @upload.save(context: :upload)
      @upload.start_upload!
      redirect_to @upload
    else
      render :new
    end
  end

  def progress
    render json: { import_status: @upload.aasm_state }
  end

  def accessibility_statement
    render "#{service.to_s.underscore}/home/accessibility_statement"
  end

  def cookie_policy
    render 'home/cookie_policy'
  end

  def cookie_settings
    render 'home/cookie_settings'
  end

  private

  def set_upload
    @upload = service::Admin::Upload.find(params[:id] || params[:upload_id])
  end

  def authorize_user
    authorize! :manage, service::Admin::Upload
  end
end
