module SupplyTeachers
  class Journey::NominatedWorkerResults
    include Steppable
    include ActiveSupport::NumberHelper

    POSITION_ID = 39

    def determine_position_id
      self.class::POSITION_ID
    end

    def inputs
      {
        looking_for: translate_input('supply_teachers.looking_for.worker'),
        worker_type: translate_input('supply_teachers.worker_type.nominated'),
        postcode: postcode,
        radius: number_to_human(radius, units: :miles)
      }
    end
  end
end
