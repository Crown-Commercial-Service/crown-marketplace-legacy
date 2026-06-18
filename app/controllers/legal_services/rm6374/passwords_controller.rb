module LegalServices
  module RM6374
    class PasswordsController < Base::PasswordsController
      include LegalServices::FrameworkStatusConcern
    end
  end
end
