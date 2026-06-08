module ManagementConsultancy
  module RM6309
    module Admin
      class ReportsController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::ReportActions
      end
    end
  end
end
