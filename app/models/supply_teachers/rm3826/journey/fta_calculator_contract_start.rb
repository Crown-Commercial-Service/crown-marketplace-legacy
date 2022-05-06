module SupplyTeachers
  module RM3826
    class Journey::FTACalculatorContractStart
      DATE_ATTIBUTES = %i[contract_start_date].freeze

      include Steppable
      include DateValidator
      include ContractStartable

      def next_step_class
        Journey::FTACalculatorContractEnd
      end
    end
  end
end
