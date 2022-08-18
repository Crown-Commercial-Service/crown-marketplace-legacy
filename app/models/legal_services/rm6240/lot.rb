module LegalServices
  module RM6240
    class Lot
      include StaticRecord

      attr_accessor :number, :description

      def self.[](number)
        Lot.find_by(number: number)
      end

      def self.all_numbers
        all.map(&:number)
      end

      def self.all_central_government
        where(number: %w[1 2])
      end
    end

    Lot.load_csv('legal_services/rm6240/lots.csv')
  end
end
