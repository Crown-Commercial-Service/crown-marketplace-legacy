module SupplyTeachers
  module RM3826
    class SchoolType
      include Virtus.model
      include StaticRecord

      attribute :id, String
      attribute :name, String
      attribute :non_profit, Axiom::Types::Boolean

      def non_profit?
        non_profit
      end
    end

    SchoolType.load_csv('supply_teachers/rm3826/school_types.csv')
  end
end
