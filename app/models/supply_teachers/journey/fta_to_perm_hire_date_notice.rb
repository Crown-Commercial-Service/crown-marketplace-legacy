module SupplyTeachers
  class Journey::FTAToPermHireDateNotice
    include Steppable

    def next_step_class
      service_name::Journey::FTAToPermFixedTermFee
    end
  end
end
