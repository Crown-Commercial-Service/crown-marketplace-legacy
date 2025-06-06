module SupplyTeachers
  module Admin
    class UploadsController < SupplyTeachers::Admin::FrameworkController
      include SharedPagesConcern

      before_action :authenticate_user!, :authorize_user, only: %i[index show new create update destroy progress]
      before_action :set_upload, only: %i[show update destroy progress]

      helper_method :service, :new_path, :index_path

      def index
        @uploads = service::Upload.all.page params[:page]
        setup_previous_uploaded_files
      end

      def show
        @attributes = service::Upload::ATTRIBUTES
      end

      def new
        @upload = service::Upload.new
        @uploads_in_progress = service::Upload.in_upload_progress
      end

      def create
        @upload = service::Upload.new(upload_params)
        @uploads_in_progress = service::Upload.in_upload_progress

        if @upload.save
          @upload.start_upload!
          redirect_to @upload
        else
          render :new
        end
      end

      def update
        if params[:approve]
          @upload.approve!
        elsif params[:reject]
          @upload.reject!
        end

        redirect_to @upload
      end

      def destroy
        @upload.destroy

        redirect_to index_path
      end

      def progress
        render json: { import_status: @upload.aasm_state }
      end

      private

      def service
        @service ||= self.class.module_parent
      end

      def set_upload
        @upload = service::Upload.find(params[:id])
      end

      def new_path
        "/supply-teachers/#{params[:framework]}/admin/uploads/new"
      end

      def index_path
        "/supply-teachers/#{params[:framework]}/admin/uploads"
      end

      def upload_params
        if params[param_key]
          params.expect(param_key => service::Upload::ATTRIBUTES)
        else
          {}
        end
      end

      def param_key
        @param_key ||= service::Upload.model_name.param_key
      end

      def setup_previous_uploaded_files
        @current_uploads = []
        service::Upload::ATTRIBUTES.each do |attr|
          upload = service::Upload.previous_uploaded_file_upload(attr)
          next if upload.nil?

          @current_uploads << {
            attribute_name: attr,
            upload: upload,
            attachment: upload.send(attr)
          }
        end
      end
    end
  end
end
