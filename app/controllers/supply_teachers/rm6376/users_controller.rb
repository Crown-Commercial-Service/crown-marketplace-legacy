module SupplyTeachers
  module RM6376
    class UsersController < Base::UsersController
      include SupplyTeachers::FrameworkStatusConcern
    end
  end
end
