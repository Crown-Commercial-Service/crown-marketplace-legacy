module LegalServices
  module RM6374
    class Journey::Suppliers
      include Steppable

      def next_step_class
        Journey::ChooseLawProfessionals
      end
    end
  end
end