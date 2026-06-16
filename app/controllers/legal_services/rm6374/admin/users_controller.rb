module LegalServices
  module RM6374
    module Admin
      class UsersController < Base::UsersController
        include LegalServices::Admin::FrameworkStatusConcern
      end
    end
  end
end
