module SupplyTeachers
  module RM6238
    class SessionsController < Base::SessionsController
      include SupplyTeachers::FrameworkStatusConcern
    end
  end
end
