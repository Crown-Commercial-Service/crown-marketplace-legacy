module LegalServices
  module RM6374
    class Journey::RecommendedLot
      include Steppable

      attribute :specialism
      attribute :recommended_or_alternatives
      attribute :lot_number, :string
      attribute :sector, :string
      attribute :result, default: -> { {} }
      attribute :service_numbers, :array, default: -> { [] }

      validates :recommended_or_alternatives, inclusion: %w[recommended alternatives]
      validates :lot_number, presence: true, if: :selecting_alternative?
      validate :lot_number_must_be_in_alternatives, if: :selecting_alternative?

      def result
        @result ||= ::LegalServices::RM6374::Journey::CrossLotCheck.evaluate(
          selected_sector: specialism == 'specific' ? nil : sector,
          selected_specialisms: service_numbers
        )
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end

      private

      def selecting_alternative?
        recommended_or_alternatives == 'alternatives'
      end

      def lot_number_must_be_in_alternatives
        valid_options = result[:alternatives].map(&:to_s)

        return if valid_options.include?(lot_number.to_s)

        errors.add(:lot_number, :blank)
      end
    end
  end
end
