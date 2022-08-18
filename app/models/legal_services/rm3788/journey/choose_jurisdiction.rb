module LegalServices
  module RM3788
    class Journey::ChooseJurisdiction < LegalServices::Journey::ChooseJurisdiction
      def next_step_class
        Journey::ChooseServices
      end
    end
  end
end
