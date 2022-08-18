module LegalServices
  class Journey::SelectLot
    include Steppable

    attribute :lot
    validates :lot, presence: true
  end
end
