module LegalServices
  class Journey::SelectLot
    include Steppable

    attribute :lot_number
    validates :lot_number, presence: true
  end
end
