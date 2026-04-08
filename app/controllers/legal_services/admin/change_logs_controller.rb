module LegalServices
  module Admin
    class ChangeLogsController < LegalServices::Admin::FrameworkController
      include SharedPagesConcern
      include ::Admin::ChangeLogsController
    end
  end
end
