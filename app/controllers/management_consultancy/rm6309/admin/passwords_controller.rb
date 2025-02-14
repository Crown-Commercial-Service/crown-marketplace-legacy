module ManagementConsultancy
  module RM6309
    module Admin
      class PasswordsController < Base::PasswordsController
        include ManagementConsultancy::Admin::FrameworkStatusConcern
      end
    end
  end
end
