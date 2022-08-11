module LegalServices
  module RM6240
    class Journey::ChooseJurisdiction < LegalServices::Journey::ChooseJurisdiction
      def next_step_class
        # Journey::Suppliers
      end
    end
  end
end
