module LegalServices
  module RM6240
    class Service
      include Virtus.model
      include StaticRecord

      attribute :lot_number, String
      attribute :service_number, String
      attribute :name, String

      alias_method :code, :service_number

      def self.all_service_code
        all.map(&:service_code)
      end

      def self.services_for_lot(lot_number)
        where(lot_number:)
      end

      def service_code
        "#{lot_number}.#{service_number}"
      end
    end

    Service.load_csv('legal_services/rm6240/services.csv')
  end
end
