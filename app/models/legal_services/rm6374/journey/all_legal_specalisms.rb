module LegalServices
  module RM6374
    class Journey::AllLegalSpecalisms
      include Steppable

      attribute :sector
      attribute :lot_number, :string, default: '1'
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def all_legal_specalisms
        Service.where('lot_id LIKE ?', "RM6374.#{lot_number}%").select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        Journey::ChooseJurisdiction
      end
    end
  end
end
