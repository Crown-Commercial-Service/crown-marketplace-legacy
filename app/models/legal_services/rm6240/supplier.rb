module LegalServices
  module RM6240
    class Supplier < ApplicationRecord
      has_many :service_offerings,
               foreign_key: :legal_services_rm6240_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      has_many :rates,
               foreign_key: :legal_services_rm6240_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      validates :name, presence: true

      def self.offering_services_in_jurisdiction(lot_number, service_numbers, jurisdiction = nil)
        valid_service_codes = set_service_codes(lot_number, service_numbers)

        ids = ServiceOffering.supplier_ids_for_service_codes_and_jurisdiction(valid_service_codes, jurisdiction)
        where(id: ids)
      end

      def self.set_service_codes(lot_number, service_numbers)
        service_numbers = ['1'] if lot_number == '3'

        Service.where(lot_number: lot_number, service_number: service_numbers).map(&:service_code)
      end

      def rate_card(lot_number, jurisdiction)
        rates.where(lot_number:, jurisdiction:)
      end
    end
  end
end
