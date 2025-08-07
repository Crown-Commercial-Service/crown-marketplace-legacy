module ManagementConsultancy
  module RM6309
    module Admin
      class DashboardController < ManagementConsultancy::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::DashboardController
      end
    end
  end
end
