module LegalServices
  module RM6374
    class Journey::RiskInnovation
      include Steppable

      attribute :sector
      attribute :lot_number, :string, default: '4'
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def risk_innovation
        Service.where(lot_id: 'RM6374.4').select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end
