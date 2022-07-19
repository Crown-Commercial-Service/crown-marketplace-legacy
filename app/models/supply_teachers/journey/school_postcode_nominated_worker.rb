module SupplyTeachers
  class Journey::SchoolPostcodeNominatedWorker
    include Steppable
    include Geolocatable

    def next_step_class
      service_name::Journey::NominatedWorkerResults
    end
  end
end
