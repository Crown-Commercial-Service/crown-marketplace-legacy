module LegalServices
  module Admin
    class DashboardController < LegalServices::Admin::FrameworkController
      include SharedPagesConcern
      include ::Admin::DashboardController
    end
  end
end
