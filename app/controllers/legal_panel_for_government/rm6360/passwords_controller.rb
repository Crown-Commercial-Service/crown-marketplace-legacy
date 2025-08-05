module LegalPanelForGovernment
  module RM6360
    class PasswordsController < Base::PasswordsController
      include LegalPanelForGovernment::FrameworkStatusConcern
    end
  end
end
