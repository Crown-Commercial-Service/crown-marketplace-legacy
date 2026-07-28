module LegalServices
  module RM6374
    class Journey::AllLegalSpecalisms
      include Steppable

      attribute :sector
      attribute :lot_number
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      after_validation :evaluate_cross_lot_check, if: -> { errors.blank? }

      def all_legal_specalisms
        Service.where('lot_id LIKE ?', 'RM6374.1%').select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        if lot_number.blank?
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
