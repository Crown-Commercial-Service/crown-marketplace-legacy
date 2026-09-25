module LegalServices
  module RM6374
    class Journey::AllLegalSpecalisms
      include Steppable

      attribute :sector
      attribute :lot_number
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def all_legal_specalisms
        Service.where('lot_id LIKE ?', 'RM6374.1%').select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        result = LegalServices::RM6374::Journey::CrossLotCheck.evaluate(
          selected_sector: sector,
          selected_specialisms: service_numbers
        )
        if result[:alternatives].any?
          Journey::RecommendedLot
        else
          Journey::ChooseJurisdiction
        end
      end
    end
  end
end
