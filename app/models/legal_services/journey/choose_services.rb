module LegalServices
  class Journey::ChooseServices
    include Steppable

    attribute :lot_id
    attribute :service_ids, Array
    validates :service_ids, presence: true

    def lot_services
      Service.where(lot_id:).order(:name)
    end

    def lot
      Lot.find(lot_id)
    end
  end
end
