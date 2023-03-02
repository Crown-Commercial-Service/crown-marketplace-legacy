module ManagementConsultancy
  module RM6187
    class PasswordsController < Base::PasswordsController
      include ManagementConsultancy::FrameworkStatusConcern
    end
  end
end
