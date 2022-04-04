module LegalServices
  module Admin
    class FrameworksController < LegalServices::FrameworkController
      include ::Admin::FrameworksConcern

      before_action :authenticate_user!
      before_action :authorize_user

      def framework_index_path
        legal_services_admin_frameworks_path
      end

      private

      def authorize_user
        authorize! :manage, LegalServices::Admin::Upload
      end
    end
  end
end
