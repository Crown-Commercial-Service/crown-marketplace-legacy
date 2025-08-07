module LegalPanelForGovernment
  module Admin
    class FrameworksController < LegalPanelForGovernment::Admin::FrameworkController
      include ::Admin::FrameworksConcern

      before_action :authenticate_user!
      before_action :authorize_user

      def framework_index_path
        legal_panel_for_government_admin_frameworks_path
      end

      private

      def authorize_user
        authorize! :manage, Framework
      end
    end
  end
end
