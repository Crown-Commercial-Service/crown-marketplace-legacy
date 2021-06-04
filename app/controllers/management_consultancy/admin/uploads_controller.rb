module ManagementConsultancy
  module Admin
    class UploadsController < ManagementConsultancy::FrameworkController
      skip_before_action :verify_authenticity_token, only: :create
      before_action :authenticate_user!
      before_action :authorize_user
      before_action :set_upload, only: %i[show progress]

      def index
        @latest_upload = ManagementConsultancy::Admin::Upload.latest_upload
        @uploads = ManagementConsultancy::Admin::Upload.all.page params[:page]
      end

      def show; end

      def new
        @upload = ManagementConsultancy::Admin::Upload.new
      end

      def create
        @upload = ManagementConsultancy::Admin::Upload.new(upload_params)

        if @upload.save(context: :upload)
          @upload.start_upload!
          redirect_to management_consultancy_admin_upload_path(@upload)
        else
          render :new
        end
      end

      def progress
        render json: { import_status: @upload.aasm_state }
      end

      def accessibility_statement
        render 'management_consultancy/home/accessibility_statement'
      end

      def cookie_policy
        render 'home/cookie_policy'
      end

      def cookie_settings
        render 'home/cookie_settings'
      end

      private

      def set_upload
        @upload = ManagementConsultancy::Admin::Upload.find(params[:id] || params[:upload_id])
      end

      def upload_params
        params.require(:management_consultancy_admin_upload).permit(:supplier_details_file, :supplier_rate_cards_file, :supplier_regional_offerings_file, :supplier_service_offerings_file) if params[:management_consultancy_admin_upload].present?
      end

      def authorize_user
        authorize! :manage, ManagementConsultancy::Admin::Upload
      end
    end
  end
end
