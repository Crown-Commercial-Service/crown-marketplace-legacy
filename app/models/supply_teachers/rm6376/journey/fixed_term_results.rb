module SupplyTeachers
  module RM6376
    class Journey::FixedTermResults < SupplyTeachers::Journey::FixedTermResults

      include Journey::Results

      def lot_id
        'RM6376.1'
      end
    end
  end
end
