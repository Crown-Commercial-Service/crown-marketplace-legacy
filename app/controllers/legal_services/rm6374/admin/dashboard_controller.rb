module LegalServices
  module RM6374
    module Admin
      class DashboardController < LegalServices::Admin::FrameworkController
        include SharedPagesConcern
        include ::Admin::DashboardActions
      end
    end
  end
end
