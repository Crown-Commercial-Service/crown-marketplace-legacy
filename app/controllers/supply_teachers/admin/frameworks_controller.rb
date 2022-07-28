module SupplyTeachers
  module Admin
    class FrameworksController < SupplyTeachers::Admin::FrameworkController
      include ::Admin::FrameworksConcern

      before_action :authenticate_user!
      before_action :authorize_user

      def framework_index_path
        supply_teachers_admin_frameworks_path
      end

      private

      def authorize_user
        authorize! :manage, Framework
      end
    end
  end
end
