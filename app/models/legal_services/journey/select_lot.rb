module LegalServices
  class Journey::SelectLot
    include Steppable

    attribute :lot
    validates :lot, presence: true

    def self.lots
      module_parent.module_parent::Lot.all.sort_by(&:number)
    end
  end
end
