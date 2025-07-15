module LegalPanelForGovernment
  class Journey < GenericJourney
    include Rails.application.routes.url_helpers

    def initialize(framework, slug, params)
      paths = JourneyPaths.new(self.class.journey_name)
      first_step_class = "LegalPanelForGovernment::#{framework}::Journey::ChooseOrganisationType".constantize
      super(first_step_class, framework, slug, params, paths)
    end

    def self.journey_name
      'legal-panel-for-government'
    end

    def start_path
      legal_panel_for_government_index_path(@framework)
    end
  end
end
