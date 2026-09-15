module LegalServices
  module RM6374
    class Journey::Suppliers
      include Steppable

      attribute :lot_number, :string

      def next_step_class
        if lot_number == '6'
          Journey::ChooseCostsLawProfessionals
        else
          Journey::ChooseLawProfessionals
        end
      end
    end
  end
end
