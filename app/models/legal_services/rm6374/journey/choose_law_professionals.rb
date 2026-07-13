module LegalServices
  module RM6374
    class Journey::ChooseLawProfessionals
      include Steppable

      PROFESSION_OPTIONS = %w[
        partner
        legal_director
        senior_solicitor
        solicitor
        nq_solicitor
        trainee
        paralegal
        legal_project_manager
        legal_document_reviewer
        all
      ].freeze

      attribute :professions, :array
      attribute :lot_number, :string

      def lot
        Lot.find("RM6374.#{lot_number}")
      end

      validates :professions, presence: true
    end
  end
end
