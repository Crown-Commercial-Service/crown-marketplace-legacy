module LegalServices
  module RM6240
    class Journey::SelectLot < LegalServices::Journey::SelectLot
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
