module LegalServices
  module RM6374
    class Journey::SingleOrMultipleSuppliers
      include Steppable

      SINGLE_OR_MULTIPLE_SUPPLIERS_OPTIONS = %w[single multiple].freeze

      attribute :lot_number, :string
      attribute :single_or_multiple_suppliers
      attribute :service_numbers, :array, default: -> { [] }
      validates :single_or_multiple_suppliers, inclusion: SINGLE_OR_MULTIPLE_SUPPLIERS_OPTIONS

      after_validation :evaluate_cross_lot_check, if: -> { errors.blank? }

      def lot
        Lot.find('RM6374.2')
      end

      def next_step_class
        result = ::LegalServices::RM6374::Journey::CrossLotCheck.evaluate(
          selected_sector: nil,
          selected_specialisms: service_numbers
        )

        if single_or_multiple_suppliers == 'single' && result[:alternatives].any?
          Journey::RecommendedLot
        else
          Journey::ChooseJurisdiction
        end
      end

      private

      def evaluate_cross_lot_check
        result = ::LegalServices::RM6374::Journey::CrossLotCheck.evaluate(
          selected_sector: nil,
          selected_specialisms: service_numbers
        )
        @lot_number = result[:recommended_lot] unless result[:alternatives].any?
      end
    end
  end
end
