module LegalServices
  module RM6240
    class Journey::SelectLot < LegalServices::Journey::SelectLot
      def next_step_class
        case lot_id
        when 'RM6240.1', 'RM6240.2'
          Journey::ChooseServices
        else
          Journey::Suppliers
        end
      end
    end
  end
end
