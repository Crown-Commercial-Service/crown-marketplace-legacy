module LegalServices
  module RM6374
    class Journey::ReviewProspectus
      include Steppable

      attribute :lot_number, :string
      attribute :review_prospectus, :string

      validates :review_prospectus, presence: true

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      def next_step_class
        if review_prospectus == 'yes'
          LegalServices::RM6374::Journey::SuppliersComparison
        else
          nil
        end
      end
    end
  end
end