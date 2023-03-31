module LegalServices
  module RM6240
    class Journey::ChooseServices < LegalServices::Journey::ChooseServices
      def services_for_lot(lot_number, _jurisdiction, _central_government)
        LegalServices::RM6240::Service.where(lot_number:).sort_by(&:name)
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end
