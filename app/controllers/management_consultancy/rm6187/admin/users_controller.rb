module ManagementConsultancy
  module RM6187
    module Admin
      class UsersController < Base::UsersController
        include ManagementConsultancy::Admin::FrameworkStatusConcern
      end
    end
  end
end
