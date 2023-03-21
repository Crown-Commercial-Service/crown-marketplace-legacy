module LegalServices
  module RM6240
    class PasswordsController < Base::PasswordsController
      include LegalServices::FrameworkStatusConcern
    end
  end
end
