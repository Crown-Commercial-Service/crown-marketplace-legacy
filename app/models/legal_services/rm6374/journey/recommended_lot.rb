module LegalServices
  module RM6374
    class Journey::RecommendedLot
      include Steppable

      attribute :lot_number, :string

      def next_step_class; end
    end
  end
end
