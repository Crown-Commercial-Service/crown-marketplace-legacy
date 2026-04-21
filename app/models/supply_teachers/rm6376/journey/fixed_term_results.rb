module SupplyTeachers
  module RM6376
    class Journey::FixedTermResults < SupplyTeachers::Journey::FixedTermResults
      attribute :postcode
      attribute :radius
      attribute :framework

      include Journey::Results

      def framework
        'RM6376'
      end

      def lot_id
        'RM6376.1'
      end
    end
  end
end
