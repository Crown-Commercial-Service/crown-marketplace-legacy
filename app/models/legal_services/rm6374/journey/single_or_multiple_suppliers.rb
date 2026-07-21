module LegalServices
  module RM6374
    class Journey::SingleOrMultipleSuppliers
      include Steppable

      SINGLE_OR_MULTIPLE_SUPPLIERS_OPTIONS = %w[single multiple].freeze

      attribute :lot_number, :string
      attribute :single_or_multiple_suppliers
      validates :single_or_multiple_suppliers, inclusion: SINGLE_OR_MULTIPLE_SUPPLIERS_OPTIONS

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def next_step_class
        if single_or_multiple_suppliers == 'single'
          Journey::ChooseJurisdiction
        else
          Journey::SelectLot
        end
      end
    end
  end
end
