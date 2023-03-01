module LegalServices
  module RM6240
    module Admin
      class SessionsController < Base::SessionsController
        include LegalServices::Admin::FrameworkStatusConcern
      end
    end
  end
end
