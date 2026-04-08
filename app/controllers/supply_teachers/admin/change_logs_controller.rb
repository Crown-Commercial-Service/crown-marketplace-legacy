module SupplyTeachers
  module Admin
    class ChangeLogsController < SupplyTeachers::Admin::FrameworkController
      include SharedPagesConcern
      include ::Admin::ChangeLogsController
    end
  end
end
