module LegalServices
  module RM6374
    class Journey::ChooseSpecialisms
      include Steppable

      attribute :sector
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def specialisms
        lot_numbers = sector == 'transport' ? %w[3] : %w[1a 1b 1c 2 3 4 6]

        Service.where(lot_id: lot_numbers.map { |lot_number| "RM6374.#{lot_number}" }).select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        Journey::SelectLot
      end
    end
  end
end
