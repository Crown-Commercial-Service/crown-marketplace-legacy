module LegalPanelForGovernment
  module RM6360
    module Admin
      class DashboardController < LegalPanelForGovernment::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::DashboardController
      end
    end
  end
end
