module SupplyTeachers
  class Journey::AgencyPayrollResults
    include Steppable
    include ActiveSupport::NumberHelper

    attribute :position_number
    attribute :offset
    

    def position
      Position.find(determine_position_id)
    end
  end
end
