module SupplyTeachers
  module RM6238
    class Lot
      include StaticRecord

      attr_accessor :number, :description

      def self.all_numbers
        all.map(&:number)
      end
    end

    Lot.load_csv('supply_teachers/rm6238/lots.csv')
  end
end
