module LegalPanelForGovernment
  module RM6360
    class SessionsController < Base::SessionsController
      include LegalPanelForGovernment::FrameworkStatusConcern
    end
  end
end
