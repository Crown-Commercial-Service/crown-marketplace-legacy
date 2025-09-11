module SupplyTeachers
  class Journey::AgencyPayrollResults
    include Steppable
    include ActiveSupport::NumberHelper

    attribute :position_number
    attribute :offset

    def determine_position_id
      @determine_position_id ||= "RM6238.1.#{position_number.to_i + offset.to_i}"
    end

    def position
      Position.find(determine_position_id)
    end

    def inputs
      {
        looking_for: translate_input('supply_teachers.looking_for.worker'),
        worker_type: translate_input('supply_teachers.worker_type.agency_supplied'),
        payroll_provider: translate_input('supply_teachers.payroll_provider.agency'),
        postcode: postcode,
        radius: number_to_human(radius, units: :miles),
        job_type: translate_input("supply_teachers.job_titles.#{position.name}"),
        term: translate_input("supply_teachers.term_types.#{position.category}"),
      }
    end
  end
end
