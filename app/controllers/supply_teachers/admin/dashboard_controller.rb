module SupplyTeachers
  module Admin
    class DashboardController < SupplyTeachers::Admin::FrameworkController
      include SharedPagesConcern
      include ::Admin::DashboardController

      private

      def framework_has_analytics?
        false
      end
    end
  end
end
