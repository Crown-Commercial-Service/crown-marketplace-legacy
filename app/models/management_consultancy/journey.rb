module ManagementConsultancy
  class Journey < GenericJourney
    include Rails.application.routes.url_helpers

    def initialize(framework, slug, params)
      paths = JourneyPaths.new(self.class.journey_name)
      first_step_class = FIRST_STEP_CLASS[framework]
      super(first_step_class, framework, slug, params, paths)
    end

    def self.journey_name
      'management-consultancy'
    end

    def start_path
      management_consultancy_rm6187_path
    end

    def next_step_path
      case next_slug
      when 'suppliers'
        management_consultancy_rm6187_suppliers_path(journey: self.class.journey_name, params: params)
      else
        super
      end
    end

    FIRST_STEP_CLASS = {
      'RM6187' => ManagementConsultancy::RM6187::Journey::ChooseLot
    }.freeze
  end
end
