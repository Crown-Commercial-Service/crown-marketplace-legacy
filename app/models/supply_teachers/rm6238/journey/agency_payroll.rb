module SupplyTeachers
  module RM6238
    class Journey::AgencyPayroll < SupplyTeachers::Journey::AgencyPayroll
     attribute :offset
     validates :offset, presence: true
    end
  end
end
