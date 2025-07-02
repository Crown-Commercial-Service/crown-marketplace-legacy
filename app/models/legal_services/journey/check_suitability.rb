module LegalServices
  class Journey::CheckSuitability
    include Steppable

    SUITABILITY_OPTIONS = %w[yes no].freeze

    attribute :service_suitable
    validates :service_suitable, inclusion: SUITABILITY_OPTIONS
  end
end
