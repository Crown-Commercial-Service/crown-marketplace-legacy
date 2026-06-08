module LegalServices
  module RM6240
    module Admin
      class ReportsController < LegalServices::Admin::FrameworkController
        include ::Admin::ReportActions
      end
    end
  end
end
