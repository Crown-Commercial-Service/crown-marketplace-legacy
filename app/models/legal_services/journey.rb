module LegalServices
  class Journey < GenericJourney
    include Rails.application.routes.url_helpers

    def initialize(framework, slug, params)
      paths = JourneyPaths.new(self.class.journey_name)
      first_step_class = "LegalServices::#{framework}::Journey::ChooseOrganisationType".constantize
      super(first_step_class, framework, slug, params, paths)
    end

    def self.journey_name
      'legal-services'
    end

    def start_path
      legal_services_index_path(@framework)
    end

    def next_step_path
      case next_slug
      when 'suppliers'
        legal_services_rm3788_suppliers_path(journey: self.class.journey_name, params: params)
      else
        super
      end
    end
  end
end
