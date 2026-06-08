module ManagementConsultancy
  module RM6187
    module Admin
      class DashboardController < ManagementConsultancy::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::DashboardActions
      end
    end
  end
end
