module LegalServices
  class Journey::ChooseServices
    include Steppable

    attribute :lot_number
    attribute :service_numbers, :array, default: -> { [] }
    validates :service_numbers, presence: true
  end
end
