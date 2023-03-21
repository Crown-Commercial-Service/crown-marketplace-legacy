module SupplyTeachers
  module RM6238
    module Admin
      class SessionsController < Base::SessionsController
        include SupplyTeachers::Admin::FrameworkStatusConcern
      end
    end
  end
end
