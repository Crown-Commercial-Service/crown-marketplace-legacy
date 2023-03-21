module SupplyTeachers
  module RM6238
    module Admin
      class UsersController < Base::UsersController
        include SupplyTeachers::Admin::FrameworkStatusConcern
      end
    end
  end
end
