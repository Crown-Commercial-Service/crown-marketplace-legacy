module SupplyTeachers
  module Admin
    class FrameworkController < ::ApplicationController
      before_action :authenticate_user!
      before_action :authorize_user
      before_action :raise_if_unrecognised_framework

      rescue_from UnrecognisedFrameworkError do
        @unrecognised_framework = params[:framework]
        params[:framework] = Framework.supply_teachers.current_framework

        render 'supply_teachers/admin/home/unrecognised_framework', status: :bad_request
      end

      protected

      def authorize_user
        authorize! :manage, SupplyTeachers::Admin
      end

      def service_scope
        :supply_teachers
      end

      def raise_if_unrecognised_framework
        raise UnrecognisedFrameworkError, 'Unrecognised Framework' unless Framework.supply_teachers.recognised_framework? params[:framework]
      end
    end
  end
end
