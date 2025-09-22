module SupplyTeachers
  module RM6238
    class BranchesController < SupplyTeachers::BranchesController
      def set_lot
        @lot = Lot.find('RM6238.1')
      end
    end
  end
end
