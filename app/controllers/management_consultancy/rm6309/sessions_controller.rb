module ManagementConsultancy
  module RM6309
    class SessionsController < Base::SessionsController
      include ManagementConsultancy::FrameworkStatusConcern
    end
  end
end
