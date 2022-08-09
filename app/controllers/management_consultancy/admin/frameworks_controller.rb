module ManagementConsultancy
  module Admin
    class FrameworksController < ManagementConsultancy::Admin::FrameworkController
      include ::Admin::FrameworksConcern

      before_action :authenticate_user!
      before_action :authorize_user

      def framework_index_path
        management_consultancy_admin_frameworks_path
      end

      private

      def authorize_user
        authorize! :manage, Framework
      end
    end
  end
end
