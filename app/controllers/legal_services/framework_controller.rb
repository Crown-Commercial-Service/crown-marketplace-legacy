module LegalServices
  class FrameworkController < ::ApplicationController
    include FrameworkStatusConcern

    before_action :authenticate_user!
    before_action :authorize_user

    protected

    def authorize_user
      authorize! :read, LegalServices
    end
  end
end
