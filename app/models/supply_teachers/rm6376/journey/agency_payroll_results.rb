module SupplyTeachers
  module RM6376
    class Journey::AgencyPayrollResults < SupplyTeachers::Journey::AgencyPayrollResults

      attribute :location
      attribute :radius

      include Journey::Results

      def determine_position_id
        @determine_position_id ||= "RM6376.1.#{position_number.to_i + offset.to_i}"
      end
    end
  end
end
