module LegalServices
  module RM6374
    class Journey::ChooseJurisdiction < LegalServices::Journey::ChooseJurisdiction
      attribute :lot_number, :string

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def next_step_class
        Journey::Suppliers
      end
    end
  end
end
