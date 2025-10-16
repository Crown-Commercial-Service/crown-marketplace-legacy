module LegalPanelForGovernment
  module RM6360
    class Journey::HaveYouReviewed
      include Steppable

      HAVE_YOU_REVIEWED_OPTIONS = %w[yes no].freeze

      attribute :lot_id

      attribute :have_you_reviewed
      validates :have_you_reviewed, inclusion: HAVE_YOU_REVIEWED_OPTIONS

      def lot
        @lot ||= Lot.find(lot_id)
      end

      def next_step_class
        case have_you_reviewed
        when 'yes'
          Journey::SelectSuppliersForComparison
        else
          Journey::Suppliers
        end
      end
    end
  end
end
