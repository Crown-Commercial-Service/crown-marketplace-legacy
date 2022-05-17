module SupplyTeachers
  module RM3826
    class RateTerm
      include StaticRecord

      attr_accessor :code, :description

      def self.[](code)
        find_by(code: code).description
      end

      def self.all_codes
        all.map(&:code)
      end
    end

    RateTerm.load_csv('supply_teachers/rm3826/rate_terms.csv')
  end
end
