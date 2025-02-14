module ManagementConsultancy
  module RM6309
    class PasswordsController < Base::PasswordsController
      include ManagementConsultancy::FrameworkStatusConcern
    end
  end
end
