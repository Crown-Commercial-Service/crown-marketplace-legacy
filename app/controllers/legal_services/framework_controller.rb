module LegalServices
  class FrameworkController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user

    protected

    def authorize_user
      authorize! :read, LegalServices
    end

    def service_scope
      :legal_services
    end
  end
end
