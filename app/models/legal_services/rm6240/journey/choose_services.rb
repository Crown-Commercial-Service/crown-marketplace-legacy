module LegalServices
  module RM6240
    class Journey::ChooseServices < LegalServices::Journey::ChooseServices
      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end
