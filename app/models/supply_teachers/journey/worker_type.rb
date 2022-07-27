module SupplyTeachers
  class Journey::WorkerType
    include Steppable

    WORKER_TYPES = ['agency_supplied', 'nominated'].freeze

    attribute :worker_type
    validates :worker_type, inclusion: WORKER_TYPES

    def next_step_class
      case worker_type
      when 'nominated'
        service_name::Journey::SchoolPostcodeNominatedWorker
      when 'agency_supplied'
        service_name::Journey::PayrollProvider
      end
    end
  end
end
