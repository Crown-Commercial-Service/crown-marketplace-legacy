module LegalServices
  module RM6240
    class UsersController < Base::UsersController
      include LegalServices::FrameworkStatusConcern
    end
  end
end
