module SupplyTeachers
  class Journey::AgencyPayroll
    include Steppable
    include Geolocatable

    attribute :offset
    validates :offset, presence: true

    attribute :position_number
    validates :position_number, presence: true

    def next_step_class
      service_name::Journey::AgencyPayrollResults
    end
  end
end
