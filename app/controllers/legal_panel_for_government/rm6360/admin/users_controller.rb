module LegalPanelForGovernment
  module RM6360
    module Admin
      class UsersController < Base::UsersController
        include LegalPanelForGovernment::Admin::FrameworkStatusConcern
      end
    end
  end
end
