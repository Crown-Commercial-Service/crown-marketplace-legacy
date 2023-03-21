module ManagementConsultancy
  module RM6187
    class UsersController < Base::UsersController
      include ManagementConsultancy::FrameworkStatusConcern
    end
  end
end
