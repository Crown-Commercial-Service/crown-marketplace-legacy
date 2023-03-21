module SupplyTeachers
  module Admin
    class FrameworkController < ::ApplicationController
      include FrameworkStatusConcern

      before_action :authenticate_user!
      before_action :authorize_user

      protected

      def authorize_user
        authorize! :manage, SupplyTeachers::Admin
      end

      def service_scope
        :supply_teachers
      end
    end
  end
end
