module LegalServices
  module RM6240
    class Journey::SelectLot < LegalServices::Journey::SelectLot
      def self.lots(central_government)
        if central_government == 'yes'
          Lot.all_central_government
        else
          Lot.all
        end.sort_by(&:number)
      end

      def next_step_class
        case lot
        when '1', '2'
          Journey::ChooseServices
          # TODO: Re-add later
          # else
          # Journey::Suppliers
        end
      end
    end
  end
end
