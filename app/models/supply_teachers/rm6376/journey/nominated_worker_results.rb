module SupplyTeachers
  module RM6376
    class Journey::NominatedWorkerResults < SupplyTeachers::Journey::NominatedWorkerResults
      POSITION_ID = 'RM6376.1.10'.freeze

      attribute :location
      attribute :radius

      include Journey::Results
    end
  end
end
