module LegalServices
  module RM6240
    class Journey::ChooseJurisdiction < LegalServices::Journey::ChooseJurisdiction
      def lot
        Lot.find("RM6240.#{lot_number}a")
      end

      def next_step_class
        Journey::Suppliers
      end
    end
  end
end
