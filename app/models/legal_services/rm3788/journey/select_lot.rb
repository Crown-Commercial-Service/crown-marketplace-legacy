module LegalServices
  module RM3788
    class Journey::SelectLot < LegalServices::Journey::SelectLot
      def self.lots(_central_government)
        Lot.all.sort_by(&:number)
      end

      def next_step_class
        case lot
        when '1'
          Journey::ChooseServices
        when '2'
          Journey::ChooseJurisdiction
        else
          Journey::Suppliers
        end
      end
    end
  end
end
