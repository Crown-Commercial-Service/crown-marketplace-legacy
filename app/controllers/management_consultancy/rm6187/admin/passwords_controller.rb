module ManagementConsultancy
  module RM6187
    module Admin
      class PasswordsController < Base::PasswordsController
        include ManagementConsultancy::Admin::FrameworkStatusConcern
      end
    end
  end
end
