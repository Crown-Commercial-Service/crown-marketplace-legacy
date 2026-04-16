module SupplyTeachers
  module RM6376
    class BranchesController < SupplyTeachers::BranchesController
      def set_lot
        @lot = Lot.find('RM6376.1')
      end
    end
  end
end
