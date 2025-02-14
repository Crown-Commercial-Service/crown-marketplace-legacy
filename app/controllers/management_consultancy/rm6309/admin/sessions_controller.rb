module ManagementConsultancy
  module RM6309
    module Admin
      class SessionsController < Base::SessionsController
        include ManagementConsultancy::Admin::FrameworkStatusConcern
      end
    end
  end
end
