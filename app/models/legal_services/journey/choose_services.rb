module LegalServices
  class Journey::ChooseServices
    include Steppable

    attribute :lot
    attribute :services, Array
    validates :services, presence: true

    def selected_lot
      service_name::Lot.find_by(number: lot)
    end
  end
end
