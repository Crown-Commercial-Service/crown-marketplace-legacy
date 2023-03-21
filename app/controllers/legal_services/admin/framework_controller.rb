module LegalServices
  module Admin
    class FrameworkController < ::ApplicationController
      include FrameworkStatusConcern

      before_action :authenticate_user!
      before_action :authorize_user

      protected

      def authorize_user
        authorize! :manage, LegalServices::Admin
      end

      def service_scope
        :legal_services
      end
    end
  end
end
