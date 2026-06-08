module SupplyTeachers
  module RM6376
    module Admin
      class ChangeLogsController < SupplyTeachers::Admin::FrameworkController
        include ::Admin::ChangeLogActions
        include SectionsConcern
      end
    end
  end
end
