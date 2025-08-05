module LegalServices
  module RM6240
    class Journey::ChooseServices < LegalServices::Journey::ChooseServices
      def lot_services
        Service.where(lot_id: "RM6240.#{lot_number}a").order(:name)
      end

      def lot
        Lot.find("RM6240.#{lot_number}a")
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end
