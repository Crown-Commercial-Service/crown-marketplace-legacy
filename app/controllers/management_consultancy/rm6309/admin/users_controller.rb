module ManagementConsultancy
  module RM6309
    module Admin
      class UsersController < Base::UsersController
        include ManagementConsultancy::Admin::FrameworkStatusConcern
      end
    end
  end
end
