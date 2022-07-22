module SupplyTeachers
  class Journey < GenericJourney
    include Rails.application.routes.url_helpers

    def initialize(framework, slug, params)
      paths = JourneyPaths.new(self.class.journey_name)
      first_step_class = FIRST_STEP_CLASS[framework]
      super(first_step_class, framework, slug, params, paths)
    end

    def self.journey_name
      'supply-teachers'
    end

    def start_path
      supply_teachers_path
    end

    def next_step_path
      case next_slug
      when 'results'
        supply_teachers_rm3826_branches_path(params: params)
      when 'master-vendor-managed-service'
        master_vendors_supply_teachers_rm3826_suppliers_path(journey: self.class.journey_name, params: params)
      when 'neutral-vendor-managed-service'
        supply_teachers_neutral_vendors_path(journey: self.class.journey_name, params: params)
      when 'calculate-temp-to-perm-fee'
        supply_teachers_temp_to_perm_fee_path(journey: self.class.journey_name, params: params)
      else
        super
      end
    end

    FIRST_STEP_CLASS = {
      'RM3826' => SupplyTeachers::RM3826::Journey::LookingFor,
      'RM6238' => SupplyTeachers::RM6238::Journey::LookingFor
    }.freeze
  end
end
