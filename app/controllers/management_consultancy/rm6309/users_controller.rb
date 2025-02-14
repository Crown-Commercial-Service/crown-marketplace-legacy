module ManagementConsultancy
  module RM6309
    class UsersController < Base::UsersController
      include ManagementConsultancy::FrameworkStatusConcern
    end
  end
end
