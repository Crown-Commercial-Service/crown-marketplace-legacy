module LegalServices
  module RM3788
    class Journey::SelectLot
      include Steppable
      attribute :lot
      validates :lot, presence: true

      def self.lots
        LegalServices::RM3788::Lot.all.sort_by(&:number)
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
