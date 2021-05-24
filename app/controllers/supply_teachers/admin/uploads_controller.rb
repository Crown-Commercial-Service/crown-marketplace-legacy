module SupplyTeachers
  module Admin
    class UploadsController < SupplyTeachers::FrameworkController
      skip_before_action :verify_authenticity_token, only: :create
      before_action :authenticate_user!
      before_action :authorize_user
      before_action :set_upload, only: %i[show update destroy]

      def index
        @uploads = Upload.all.page params[:page]
        setup_previous_uploaded_files
      end

      def show
        @attributes = Upload::ATTRIBUTES
      end

      def new
        @upload = Upload.new
        @uploads_in_progress = Upload.in_upload_progress
      end

      def create
        @upload = Upload.new(upload_params)
        @uploads_in_progress = Upload.in_upload_progress

        if @upload.save
          @upload.start_upload!
          redirect_to supply_teachers_admin_upload_path(id: @upload.id)
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
        redirect_to supply_teachers_admin_upload_path
      end

      def destroy
        @upload.destroy
        redirect_to supply_teachers_admin_uploads_path
      end

      def accessibility_statement
        render 'supply_teachers/home/accessibility_statement'
      end

      def cookie_policy
        render 'home/cookie_policy'
      end

      def cookie_settings
        render 'home/cookie_settings'
      end

      private

      def set_upload
        @upload = Upload.find(params[:id] || params[:upload_id])
      end

      def upload_params
        params.require(:supply_teachers_admin_upload).permit(:current_accredited_suppliers, :geographical_data_all_suppliers, :lot_1_and_lot_2_comparisons, :master_vendor_contacts, :neutral_vendor_contacts, :pricing_for_tool, :supplier_lookup) if params[:supply_teachers_admin_upload].present?
      end

      def setup_previous_uploaded_files
        @current_uploads = []
        Upload::ATTRIBUTES.each do |attr|
          upload = Upload.previous_uploaded_file_upload(attr)
          next if upload.nil?

          @current_uploads << {
            attribute_name: attr,
            upload: upload,
            attachment: upload.send(attr)
          }
        end
      end

      def authorize_user
        authorize! :manage, SupplyTeachers::Admin::Upload
      end
    end
  end
end
