module LegalServices
  module RM6374
    class FrameworkController < LegalServices::FrameworkController
      before_action :redirect_to_buyer_detail
    end
  end
end
