module SupplyTeachers
  module RM6376
    class PasswordsController < Base::PasswordsController
      include SupplyTeachers::FrameworkStatusConcern
    end
  end
end
