module SupplyTeachers
  module RM6376
    module Admin
      class PasswordsController < Base::PasswordsController
        include SupplyTeachers::Admin::FrameworkStatusConcern
      end
    end
  end
end
