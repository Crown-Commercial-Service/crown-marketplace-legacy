module LegalServices
  module RM3788
    class Journey::ChooseJurisdiction
      include Steppable

      JURISDICTIONS = %w[a b c].freeze

      attribute :jurisdiction
      validates :jurisdiction, inclusion: JURISDICTIONS

      def next_step_class
        Journey::ChooseServices
      end
    end
  end
end
