module SupplyTeachers
  module RM6238
    module Admin
      class DashboardController < SupplyTeachers::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::DashboardActions

        private

        def framework_has_analytics?
          false
        end
      end
    end
  end
end
