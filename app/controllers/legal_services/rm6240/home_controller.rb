module LegalServices
  module RM6240
    class HomeController < LegalServices::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern
    end
  end
end
