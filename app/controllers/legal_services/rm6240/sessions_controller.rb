module LegalServices
  module RM6240
    class SessionsController < Base::SessionsController
      include LegalServices::FrameworkStatusConcern
    end
  end
end
