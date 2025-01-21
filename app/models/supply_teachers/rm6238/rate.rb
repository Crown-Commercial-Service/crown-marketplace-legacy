module SupplyTeachers
  module RM6238
    class Rate < ApplicationRecord
      belongs_to :supplier,
                 foreign_key: :supply_teachers_rm6238_supplier_id,
                 inverse_of: :rates

      validates :lot_number, presence: true,
                             uniqueness: { scope: %i[supplier term job_type] },
                             inclusion: { in: Lot.all_numbers }

      validates :job_type, presence: true,
                           uniqueness: { scope: %i[supplier term lot_number] },
                           inclusion: { in: JobType.all_codes }

      validates :term,
                presence: { if: :term_required? },
                absence: { unless: :term_required? },
                inclusion: { in: Term.all_codes, allow_blank: true }

      validates :rate,
                presence: true,
                numericality: { only_integer: true }

      def self.nominated_worker
        where(job_type: 'nominated')
      end

      def self.fixed_term
        where(job_type: 'fixed_term')
      end

      def self.direct_provision
        where(lot_number: '1')
      end

      def self.master_vendor(threshold_position)
        where(lot_number: THRESHOLD_POSITION_TO_LOT_NUMBER[threshold_position])
      end

      def self.education_technology_platforms
        where(lot_number: '4')
      end

      def self.rate_for(job_type:, term:)
        where(job_type: job_type&.code, term: term&.code)
      end

      def value
        rate / 100.0
      end

      def percentage?
        ['over_12_week', 'fixed_term'].include?(job_type)
      end

      def term_required?
        JobType.find_term_allowed_by(code: job_type).present?
      end

      THRESHOLD_POSITION_TO_LOT_NUMBER = {
        below_threshold: '2.1',
        above_threshold: '2.2'
      }.freeze
    end
  end
end
