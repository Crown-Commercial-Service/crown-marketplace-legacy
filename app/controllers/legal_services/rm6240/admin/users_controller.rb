module LegalServices
  module RM6240
    module Admin
      class UsersController < Base::UsersController
        include LegalServices::Admin::FrameworkStatusConcern
      end
    end
  end
end
