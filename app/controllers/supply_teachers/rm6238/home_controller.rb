module SupplyTeachers
  module RM6238
    class HomeController < SupplyTeachers::FrameworkController
      include BuyerSharedPagesConcern
      include SharedPagesConcern
    end
  end
end
