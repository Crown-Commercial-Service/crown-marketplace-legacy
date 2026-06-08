module SupplyTeachers
  module RM6238
    module Admin
      class ChangeLogsController < SupplyTeachers::Admin::FrameworkController
        include ::Admin::ChangeLogActions
        include SectionsConcern
      end
    end
  end
end
