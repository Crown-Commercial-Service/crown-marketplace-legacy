module ManagementConsultancy
  module RM6187
    module Admin
      class ChangeLogsController < ManagementConsultancy::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::ChangeLogsController
      end
    end
  end
end
