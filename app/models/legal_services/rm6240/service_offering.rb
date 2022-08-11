module LegalServices
  module RM6240
    class ServiceOffering < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :legal_services_rm6240_supplier_id,
                 inverse_of: :service_offerings

      validates :service_code,
                presence: true,
                uniqueness: { scope: %i[supplier jurisdiction] },
                inclusion: { in: Service.all_service_code }

      validates :jurisdiction,
                presence: { if: :jurisdiction_required? },
                absence: { unless: :jurisdiction_required? },
                inclusion: { in: Jurisdiction.all_codes, allow_blank: true }

      def self.supplier_ids_for_service_codes_and_jurisdiction(service_codes, jurisdiction = nil)
        where(service_code: service_codes, jurisdiction: jurisdiction)
          .group(:legal_services_rm6240_supplier_id)
          .having("COUNT(service_code) = #{service_codes.count}")
          .pluck(:legal_services_rm6240_supplier_id)
      end

      private

      def jurisdiction_required?
        service_code != '3.1'
      end
    end
  end
end
