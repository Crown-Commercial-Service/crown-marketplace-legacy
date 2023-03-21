module SupplyTeachers
  module RM6238
    class UsersController < Base::UsersController
      include SupplyTeachers::FrameworkStatusConcern
    end
  end
end
