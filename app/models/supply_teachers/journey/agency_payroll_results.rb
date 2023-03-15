module SupplyTeachers
  class Journey::AgencyPayrollResults
    include Steppable
    include ActiveSupport::NumberHelper

    attribute :job_type
    attribute :term

    def rates
      service_name::Rate.direct_provision.rate_for(job_type:, term:)
    end

    def rate(branch)
      branch.supplier.rate_for(job_type:, term:)
    end

    def job_type
      service_name::JobType.find_role_by(code: @job_type)
    end

    def term
      service_name::Term.find_by(code: @term)
    end

    def inputs
      {
        looking_for: translate_input('supply_teachers.looking_for.worker'),
        worker_type: translate_input('supply_teachers.worker_type.agency_supplied'),
        payroll_provider: translate_input('supply_teachers.payroll_provider.agency'),
        postcode: postcode,
        radius: number_to_human(radius, units: :miles),
        job_type: job_type.description,
        term: term.description,
      }
    end
  end
end
