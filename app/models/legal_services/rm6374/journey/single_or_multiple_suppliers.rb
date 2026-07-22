module LegalServices
  module RM6374
    class Journey::SingleOrMultipleSuppliers
      include Steppable

      SINGLE_OR_MULTIPLE_SUPPLIERS_OPTIONS = %w[single multiple].freeze

      attribute :lot_number, :string
      attribute :single_or_multiple_suppliers
      attribute :service_numbers, :array, default: -> { [] }
      validates :single_or_multiple_suppliers, inclusion: SINGLE_OR_MULTIPLE_SUPPLIERS_OPTIONS

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def next_step_class
        if single_or_multiple_suppliers == 'single'
          Journey::ChooseJurisdiction
        else
          result = ::LegalServices::RM6374::Journey::CrossLotCheck.evaluate(
            selected_sector: nil,
            selected_specialisms: service_numbers
          )

          if result[:alternatives].present?
            Journey::RecommendedLot
          else
            Journey::ChooseJurisdiction
          end
        end
      end
    end
  end
end
