module SupplyTeachers
  module RM6238
    class Supplier < ApplicationRecord
      has_many :branches,
               foreign_key: :supply_teachers_rm6238_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      has_many :rates,
               foreign_key: :supply_teachers_rm6238_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      has_many :managed_service_providers,
               foreign_key: :supply_teachers_rm6238_supplier_id,
               inverse_of: :supplier,
               dependent: :destroy

      validates :name, presence: true

      def self.with_master_vendor_rates(threshold_position)
        Rate.includes(:supplier).master_vendor(threshold_position).map(&:supplier).uniq
      end

      def self.with_education_technology_platforms_rates
        Rate.includes(:supplier).education_technology_platforms.map(&:supplier).uniq
      end

      def nominated_worker_rate
        return if direct_provision_rates.nominated_worker.first.blank?

        direct_provision_rates.nominated_worker.first.value
      end

      def fixed_term_rate
        return nil if direct_provision_rates.fixed_term.first.blank?

        direct_provision_rates.fixed_term.first.value
      end

      def rate_for(job_type:, term:)
        direct_provision_rates.rate_for(job_type: job_type, term: term).first&.value
      end

      def master_vendor_rates_grouped_by_job_type(threshold_position)
        rates.master_vendor(threshold_position).group_by(&:job_type)
      end

      def education_technology_platforms_rates_grouped_by_job_type
        rates.education_technology_platforms.group_by(&:job_type)
      end

      def rates_grouped_by_job_type
        rates.direct_provision.group_by(&:job_type)
      end

      def direct_provision_rates
        rates.direct_provision
      end
    end
  end
end
