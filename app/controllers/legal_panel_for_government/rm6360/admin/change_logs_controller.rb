module LegalPanelForGovernment
  module RM6360
    module Admin
      class ChangeLogsController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::ChangeLogActions
        include SectionsConcern
      end
    end
  end
end
