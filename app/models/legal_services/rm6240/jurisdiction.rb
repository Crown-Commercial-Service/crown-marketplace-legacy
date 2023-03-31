module LegalServices
  module RM6240
    class Jurisdiction
      include StaticRecord

      attr_accessor :code, :name

      def self.[](code)
        Jurisdiction.find_by(code:)
      end

      def self.all_codes
        all.map(&:code)
      end
    end

    Jurisdiction.load_csv('legal_services/rm6240/jurisdictions.csv')
  end
end
