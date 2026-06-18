module LegalServices
  module RM6374
    class BuyerDetailsController < LegalServices::RM6374::FrameworkController
      include BuyerDetailsConcern
    end
  end
end
