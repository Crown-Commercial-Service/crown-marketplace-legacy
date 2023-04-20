module LegalServices
  module RM6240
    class Position
      include StaticRecord

      attr_accessor :code, :name

      def self.[](code)
        Position.find_by(code:)
      end

      def self.all_codes
        all.map(&:code)
      end
    end

    Position.load_csv('legal_services/rm6240/position.csv')
  end
end
