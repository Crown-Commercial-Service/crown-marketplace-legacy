module LegalPanelForGovernment
  module RM6360
    class UsersController < Base::UsersController
      include LegalPanelForGovernment::FrameworkStatusConcern
    end
  end
end
