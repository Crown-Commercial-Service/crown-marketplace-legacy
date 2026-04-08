module LegalPanelForGovernment
  module RM6360
    module Admin
      class ChangeLogsController < LegalPanelForGovernment::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::ChangeLogsController
      end
    end
  end
end
