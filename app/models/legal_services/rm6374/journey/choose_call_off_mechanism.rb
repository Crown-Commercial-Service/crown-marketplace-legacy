module LegalServices
  module RM6374
    class Journey::ChooseCallOffMechanism
      include Steppable

      CALL_OFF_MECHANISM_OPTIONS = %w[award_with_competition rapid_award quotation_process].freeze

      attribute :lot_number
      attribute :call_off_mechanism

      validates :call_off_mechanism, presence: true
      validates :call_off_mechanism, inclusion: CALL_OFF_MECHANISM_OPTIONS

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def next_step_class
        case call_off_mechanism
        when 'award_with_competition'
          Journey::SuppliersComparison
        when 'rapid_award'
          Journey::ReviewProspectus
        when 'quotation_process'
          Journey::CompareSelectSuppliers
        end
      end
    end
  end
end
