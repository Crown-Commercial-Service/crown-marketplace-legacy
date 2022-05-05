module LegalServices
  class Journey < GenericJourney
    include Rails.application.routes.url_helpers

    def initialize(framework, slug, params)
      paths = JourneyPaths.new(self.class.journey_name)
      first_step_class = FIRST_STEP_CLASS[framework]
      super(first_step_class, framework, slug, params, paths)
    end

    def self.journey_name
      'legal-services'
    end

    def start_path
      legal_services_rm3788_path
    end

    def next_step_path
      case next_slug
      when 'suppliers'
        legal_services_rm3788_suppliers_path(journey: self.class.journey_name, params: params)
      else
        super
      end
    end

    FIRST_STEP_CLASS = {
      'RM3788' => LegalServices::RM3788::Journey::ChooseOrganisationType
    }.freeze
  end
end
