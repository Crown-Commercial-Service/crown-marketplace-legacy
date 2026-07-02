module LegalServices
  module RM6374
    class Journey::CostService
      include Steppable

      attribute :sector
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def cost_service
        Service.where(lot_id: 'RM6374.6').select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        Journey::SelectLot
      end
    end
  end
end
