module LegalPanelForGovernment
  module Admin
    class FrameworkController < ApplicationController
      include FrameworkStatusConcern

      before_action :authenticate_user!
      before_action :authorize_user

      protected

      def authorize_user
        authorize! :manage, LegalPanelForGovernment::Admin
      end

      def service_scope
        :legal_panel_for_government
      end
    end
  end
end
