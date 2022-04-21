module ManagementConsultancy
  module RM6187
    class Service
      include StaticRecord

      attr_accessor :code, :name, :lot_number, :framework

      def self.all_codes
        all.map(&:code)
      end
    end

    Service.load_csv('management_consultancy/rm6187/services.csv')
  end
end
