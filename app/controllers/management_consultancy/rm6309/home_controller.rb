module ManagementConsultancy
  module RM6309
    class HomeController < ManagementConsultancy::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern
    end
  end
end
