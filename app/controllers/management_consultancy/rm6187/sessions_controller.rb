module ManagementConsultancy
  module RM6187
    class SessionsController < Base::SessionsController
      include ManagementConsultancy::FrameworkStatusConcern
    end
  end
end
