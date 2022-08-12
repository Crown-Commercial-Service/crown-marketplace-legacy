module LegalServices
  module RM3788
    class HomeController < LegalServices::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern
    end
  end
end
