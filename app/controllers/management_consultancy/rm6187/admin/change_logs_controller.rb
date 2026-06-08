module ManagementConsultancy
  module RM6187
    module Admin
      class ChangeLogsController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::ChangeLogsController
        include SectionsConcern
      end
    end
  end
end
