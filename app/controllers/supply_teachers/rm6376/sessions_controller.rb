module SupplyTeachers
  module RM6376
    class SessionsController < Base::SessionsController
      include SupplyTeachers::FrameworkStatusConcern
    end
  end
end
