module LegalServices
  module RM6374
    class UsersController < Base::UsersController
      include LegalServices::FrameworkStatusConcern
    end
  end
end
