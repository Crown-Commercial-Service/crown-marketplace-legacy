module LegalServices
  module RM6374
    class Journey::ChooseSector
      include Steppable

      SECTOR_OPTIONS = %w[health local_community government_policy education defence infrastructure culture transport].freeze

      attribute :sector
      validates :sector, inclusion: SECTOR_OPTIONS

      def next_step_class
        Journey::ChooseSpecialisms
      end
    end
  end
end
