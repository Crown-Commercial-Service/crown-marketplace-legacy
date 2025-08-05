module SupplyTeachers
  class Journey::AgencyPayrollResults
    include Steppable
    include ActiveSupport::NumberHelper

    attribute :position_id
    attribute :offset

    def determine_position_id
      @determine_position_id ||= position_id.to_i + offset.to_i
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
        job_type: translate_input("supply_teachers.job_titles.#{position.position}"),
        term: translate_input("supply_teachers.term_types.#{position.position_type}"),
      }
    end
  end
end
