module LegalServices
  module RM6374
    class Journey::SingleOrMultipleSuppliers
      include Steppable

      attribute :single_or_multiple_suppliers
      validates :single_or_multiple_suppliers, presence: true

      def next_step_class
        Journey::Specific
      end
    end
  end
end
