module ManagementConsultancy
  module Admin
    class FrameworkController < ApplicationController
      include FrameworkStatusConcern

      before_action :authenticate_user!
      before_action :authorize_user

      protected

      def authorize_user
        authorize! :manage, ManagementConsultancy::Admin
      end

      def service_scope
        :management_consultancy
      end
    end
  end
end
