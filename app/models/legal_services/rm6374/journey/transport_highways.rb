module LegalServices
  module RM6374
    class Journey::TransportHighways
      include Steppable

      attribute :sector
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def transport_highways
        Service.where(lot_id: 'RM6374.5').select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end
