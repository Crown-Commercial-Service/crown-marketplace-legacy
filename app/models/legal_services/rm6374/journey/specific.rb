module LegalServices
  module RM6374
    class Journey::Specific
      include Steppable

      attribute :sector
      attribute :lot_number, :string, default: '2'
      attribute :service_numbers, :array, default: -> { [] }
      validates :service_numbers, presence: true

      def specific
        Service.where('lot_id LIKE ?', "RM6374.#{lot_number}%").select(:name, 'number::integer').distinct('number::integer').order('number::integer')
      end

      def next_step_class
        if service_numbers.size >= 2
          Journey::SingleOrMultipleSuppliers
        else
          Journey::ChooseJurisdiction
        end
      end
    end
  end
end
