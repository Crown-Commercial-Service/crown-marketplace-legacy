module LegalServices
  module Admin
    class FrameworkController < ::ApplicationController
      before_action :authenticate_user!
      before_action :authorize_user
      before_action :raise_if_unrecognised_framework

      rescue_from UnrecognisedFrameworkError do
        @unrecognised_framework = params[:framework]
        params[:framework] = Framework.legal_services.current_framework

        render 'legal_services/admin/home/unrecognised_framework', status: :bad_request
      end

      protected

      def authorize_user
        authorize! :manage, LegalServices::Admin
      end

      def service_scope
        :legal_services
      end

      def raise_if_unrecognised_framework
        raise UnrecognisedFrameworkError, 'Unrecognised Framework' unless Framework.legal_services.recognised_framework? params[:framework]
      end
    end
  end
end
