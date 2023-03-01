module SupplyTeachers
  module RM6238
    module Admin
      class PasswordsController < Base::PasswordsController
        include SupplyTeachers::Admin::FrameworkStatusConcern
      end
    end
  end
end
