module LegalServices
  class Journey::ChooseJurisdiction
    include Steppable

    JURISDICTIONS = %w[a b c].freeze

    attribute :lot_number
    attribute :jurisdiction
    validates :jurisdiction, inclusion: JURISDICTIONS
  end
end
