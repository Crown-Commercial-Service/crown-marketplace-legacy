module SupplyTeachers
  module RM6238
    class PasswordsController < Base::PasswordsController
      include SupplyTeachers::FrameworkStatusConcern
    end
  end
end
