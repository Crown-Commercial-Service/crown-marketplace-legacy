module SupplyTeachers
  module RM6376
    module Admin
      class UsersController < Base::UsersController
        include SupplyTeachers::Admin::FrameworkStatusConcern
      end
    end
  end
end
