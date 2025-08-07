module LegalServices
  module RM6240
    class Journey::SelectLot < LegalServices::Journey::SelectLot
      def self.lots
        Lot.where(id: ['RM6240.1a', 'RM6240.2a', 'RM6240.3']).order('lots.number')
      end

      def next_step_class
        case lot_number
        when '1', '2'
          Journey::ChooseServices
        else
          Journey::Suppliers
        end
      end
    end
  end
end
