module SupplyTeachers
  class FrameworkController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user

    protected

    def authorize_user
      authorize! :read, SupplyTeachers
    end
  end
end
