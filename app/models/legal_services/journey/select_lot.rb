module LegalServices
  class Journey::SelectLot
    include Steppable

    attribute :lot_id
    validates :lot_id, presence: true

    def self.lots
      Lot.where(framework_id: framework).order('lots.number::integer')
    end
  end
end
