module SupplyTeachers
  module RM3826
    class Journey::FTAToPermHireDateNotice
      include Steppable

      def next_step_class
        Journey::FTAToPermFixedTermFee
      end
    end
  end
end
