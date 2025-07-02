module LegalServices
  class Journey::ChooseJurisdiction
    include Steppable

    JURISDICTION_IDS = %w[GB-EW GB-SC GB-NI].freeze

    attribute :lot_id
    attribute :jurisdiction_id
    validates :jurisdiction_id, inclusion: JURISDICTION_IDS

    def lot
      Lot.find(lot_id)
    end
  end
end
