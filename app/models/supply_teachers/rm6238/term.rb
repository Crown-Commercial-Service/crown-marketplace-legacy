module SupplyTeachers
  module RM6238
    class Term
      include StaticRecord

      attr_accessor :code, :description

      def self.[](code)
        find_by(code:).description
      end

      def self.all_codes
        all.map(&:code)
      end
    end

    Term.load_csv('supply_teachers/rm6238/term.csv')
  end
end
