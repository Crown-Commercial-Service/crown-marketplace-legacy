module LegalServices
  module RM6374
    class Journey::ChooseCostsLawProfessionals
      include Steppable

      PROFESSION_OPTIONS = %w[
        all
        solicitor_more_than_8_years
        solicitor_more_than_4_years
        solicitor_less_than_4_years
        solicitor_paralegal
      ].freeze

      attribute :professions, :array
      attribute :lot_number, :string

      def lot
        Lot.find('RM6374.6')
      end

      validates :professions, presence: true

      def next_step_class
        Journey::ChooseCallOffMechanism
      end
    end
  end
end
