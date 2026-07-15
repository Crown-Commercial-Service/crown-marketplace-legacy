module LegalServices
  module RM6374
    class Journey::ChooseCallOffMechanism
      include Steppable

      attribute :call_off_mechanism, :string
      attribute :lot_number, :string

      validates :call_off_mechanism, presence: true

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def next_step_class
        case call_off_mechanism
        when 'direct_competition'
          Journey::DirectCompetition
        when 'rapid_award'
          Journey::SupplierProspectus
        when 'quotation_process'
          Journey::CompareSelectSuppliers
        end
      end
    end
  end
end
