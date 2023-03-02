module ManagementConsultancy
  module RM6187
    module Admin
      class SessionsController < Base::SessionsController
        include ManagementConsultancy::Admin::FrameworkStatusConcern
      end
    end
  end
end
