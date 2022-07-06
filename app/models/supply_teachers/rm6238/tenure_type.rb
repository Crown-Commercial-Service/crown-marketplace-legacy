module SupplyTeachers
  module RM6238
    class TenureType
      include StaticRecord

      attr_accessor :code, :description

      def self.[](code)
        find_by(code: code).description
      end

      def self.all_codes
        all.map(&:code)
      end
    end

    TenureType.load_csv('supply_teachers/rm6238/tenure_type.csv')
  end
end
