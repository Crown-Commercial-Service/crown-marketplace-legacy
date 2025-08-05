module LegalPanelForGovernment
  module RM6360
    class HomeController < LegalPanelForGovernment::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern
    end
  end
end
