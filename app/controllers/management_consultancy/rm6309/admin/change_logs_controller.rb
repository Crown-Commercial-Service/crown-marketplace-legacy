module ManagementConsultancy
  module RM6309
    module Admin
      class ChangeLogsController < ManagementConsultancy::Admin::FrameworkController
        include ::Admin::ChangeLogActions
        include SectionsConcern
      end
    end
  end
end
