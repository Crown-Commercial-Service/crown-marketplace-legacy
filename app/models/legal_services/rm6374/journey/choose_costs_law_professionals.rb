module LegalServices
  module RM6374
    class Journey::ChooseCostsLawProfessionals
      include Steppable

      PROFESSION_OPTIONS = %w[
        grade_a
        grade_b
        grade_c
        grade_d
        all
      ].freeze

      attribute :professions, :array
      attribute :lot_number, :string

      def lot
        Lot.find('RM6374.6')
      end

      validates :professions, presence: true
    end
  end
end
