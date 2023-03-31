module ManagementConsultancy
  module RM6187
    class Lot
      include StaticRecord

      attr_accessor :number, :description, :framework

      def self.[](number)
        Lot.find_by(number:)
      end

      def full_description
        "#{description} (#{number})"
      end

      def self.all_numbers
        all.map(&:number)
      end

      def services
        Service.where(lot_number: number).sort_by(&:name)
      end
    end

    Lot.load_csv('management_consultancy/rm6187/lots.csv')
  end
end
