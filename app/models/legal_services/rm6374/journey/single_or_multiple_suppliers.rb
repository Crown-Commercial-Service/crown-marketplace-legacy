module LegalServices
  module RM6374
    class Journey::SingleOrMultipleSuppliers
      include Steppable

      single_or_multiple_suppliers = %w[single multiple].freeze

      attribute :single_or_multiple_suppliers, 
      validates :single_or_multiple_suppliers, presence: true

      def next_step_class
        Journey::Specific
      end

    end 
  end
end