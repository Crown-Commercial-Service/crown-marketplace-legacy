module LegalServices
  class Journey::ChooseJurisdiction
    include Steppable

    JURISDICTIONS = %w[a b c].freeze

    attribute :lot
    attribute :jurisdiction
    validates :jurisdiction, inclusion: JURISDICTIONS

    def selected_lot
      service_name::Lot.find_by(number: lot)
    end
  end
end
