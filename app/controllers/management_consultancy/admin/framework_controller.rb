module ManagementConsultancy
  module Admin
    class FrameworkController < ::ApplicationController
      before_action :authenticate_user!
      before_action :authorize_user
      before_action :raise_if_unrecognised_framework

      rescue_from UnrecognisedFrameworkError do
        @unrecognised_framework = params[:framework]
        params[:framework] = Framework.management_consultancy.current_framework

        render 'management_consultancy/admin/home/unrecognised_framework', status: :bad_request
      end

      protected

      def authorize_user
        authorize! :manage, ManagementConsultancy::Admin
      end

      def service_scope
        :management_consultancy
      end

      def raise_if_unrecognised_framework
        raise UnrecognisedFrameworkError, 'Unrecognised Framework' unless Framework.management_consultancy.recognised_framework? params[:framework]
      end
    end
  end
end
