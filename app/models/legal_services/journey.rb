module LegalServices
  class Journey < GenericJourney
    include Rails.application.routes.url_helpers

    def initialize(framework, slug, params)
      paths = JourneyPaths.new(self.class.journey_name)
      first_step_class = "LegalServices::#{framework}::Journey::#{FRAMEWORK_TO_FIRST_STEP_CLASS[framework]}".constantize
      super(first_step_class, framework, slug, params, paths)
    end

    def self.journey_name
      'legal-services'
    end

    def start_path
      legal_services_index_path(@framework)
    end

    FRAMEWORK_TO_FIRST_STEP_CLASS = {
      'RM6240' => 'ChooseOrganisationType',
      'RM6374' => 'InformationAboutYourRequirement',
    }.freeze
  end
end
