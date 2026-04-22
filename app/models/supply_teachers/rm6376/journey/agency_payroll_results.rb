module SupplyTeachers
  module RM6376
    class Journey::AgencyPayrollResults < SupplyTeachers::Journey::AgencyPayrollResults

      include Journey::Results

      def determine_position_id
        @determine_position_id ||= "RM6376.1.#{position_number.to_i}"
      end

      def inputs
        {
          looking_for: translate_input('supply_teachers.looking_for.worker'),
          worker_type: translate_input('supply_teachers.worker_type.agency_supplied'),
          payroll_provider: translate_input('supply_teachers.payroll_provider.agency'),
          postcode: postcode,
          radius: number_to_human(radius, units: :miles),
          job_type: I18n.t("supply_teachers.rm6376.shared.job_titles.#{position.name}")
        }
      end
    end
  end
end
