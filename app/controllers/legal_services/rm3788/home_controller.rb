module LegalServices
  module RM3788
    class HomeController < LegalServices::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern

      def service_not_suitable
        @back_path = :back
      end
    end
  end
end
