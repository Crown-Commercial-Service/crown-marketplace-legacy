module LegalServices
  class Journey::CheckSuitability
    include Steppable

    SUITABILITY_OPTIONS = %w[yes no].freeze

    attribute :service_suitable
    attribute :lot
    validates :service_suitable, inclusion: ['yes', 'no']
  end
end
