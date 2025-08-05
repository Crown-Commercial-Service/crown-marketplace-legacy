module LegalPanelForGovernment
  module RM6360
    module Admin
      class PasswordsController < Base::PasswordsController
        include LegalPanelForGovernment::Admin::FrameworkStatusConcern
      end
    end
  end
end
