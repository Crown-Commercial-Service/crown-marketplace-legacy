module ManagementConsultancy
  module Admin
    class FrameworksController < ManagementConsultancy::FrameworkController
      include ::Admin::FrameworksConcern

      before_action :authenticate_user!
      before_action :authorize_user

      def framework_index_path
        management_consultancy_admin_frameworks_path
      end

      private

      def authorize_user
        authorize! :manage, ManagementConsultancy::Admin::Upload
      end
    end
  end
end
