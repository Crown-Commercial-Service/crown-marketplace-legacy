module LegalServices
  module RM6240
    class Rate < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :legal_services_rm6240_supplier_id,
                 inverse_of: :rates

      validates :lot_number,
                presence: true,
                uniqueness: { scope: %i[supplier jurisdiction position] },
                inclusion: { in: Lot.all_numbers }

      validates :jurisdiction,
                presence: { if: :jurisdiction_required? },
                absence: { unless: :jurisdiction_required? },
                inclusion: { in: Jurisdiction.all_codes, allow_blank: true }

      validates :position,
                presence: true,
                inclusion: { in: Position.all_codes }

      validates :rate,
                presence: true,
                numericality: { only_integer: true }

      def value
        rate / 100.0
      end

      private

      def jurisdiction_required?
        lot_number != '3'
      end
    end
  end
end
