module ManagementConsultancy
  module RM6187
    class Supplier < ApplicationRecord
      has_many :service_offerings,
               foreign_key: :management_consultancy_rm6187_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      has_many :rate_cards,
               foreign_key: :management_consultancy_rm6187_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      validates :name, presence: true

      def self.available_in_lot(lot_number)
        joins(:service_offerings)
          .merge(ServiceOffering.for_lot(lot_number))
          .includes(:service_offerings)
          .uniq
      end

      def self.offering_services(lot_number, service_codes)
        lot_service_codes = Service.where(lot_number: lot_number).map(&:code)
        valid_service_codes = service_codes & lot_service_codes
        ids = ServiceOffering.supplier_ids_for_service_codes(valid_service_codes)
        where(id: ids)
      end

      def self.delete_all_with_dependents
        ServiceOffering.delete_all
        RateCard.delete_all
        delete_all
      end

      def services_in_lot(lot_number)
        service_offerings.select { |so| so.lot_number == lot_number }.map(&:service)
      end
    end
  end
end
