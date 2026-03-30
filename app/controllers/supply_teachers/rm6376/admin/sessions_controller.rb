module SupplyTeachers
  module RM6376
    module Admin
      class SessionsController < Base::SessionsController
        include SupplyTeachers::Admin::FrameworkStatusConcern
      end
    end
  end
end
