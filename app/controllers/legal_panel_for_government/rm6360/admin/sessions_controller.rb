module LegalPanelForGovernment
  module RM6360
    module Admin
      class SessionsController < Base::SessionsController
        include LegalPanelForGovernment::Admin::FrameworkStatusConcern
      end
    end
  end
end
