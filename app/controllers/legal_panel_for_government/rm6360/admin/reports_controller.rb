module LegalPanelForGovernment
  module RM6360
    module Admin
      class ReportsController < LegalPanelForGovernment::Admin::FrameworkController
        include ::Admin::ReportActions
      end
    end
  end
end
