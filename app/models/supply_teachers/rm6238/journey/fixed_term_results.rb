module SupplyTeachers
  module RM6238
    class Journey::FixedTermResults < SupplyTeachers::Journey::FixedTermResults
      include Journey::Results

      def framework
        'RM6238'
      end
    end
  end
end
