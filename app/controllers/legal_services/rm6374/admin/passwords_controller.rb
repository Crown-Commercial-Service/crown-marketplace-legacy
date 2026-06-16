module LegalServices
  module RM6374
    module Admin
      class PasswordsController < Base::PasswordsController
        include LegalServices::Admin::FrameworkStatusConcern
      end
    end
  end
end
