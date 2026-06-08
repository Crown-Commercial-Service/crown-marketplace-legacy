module ManagementConsultancy
  module RM6187
    module Admin
      class ChangeLogsController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::ChangeLogActions
        include SectionsConcern
      end
    end
  end
end
