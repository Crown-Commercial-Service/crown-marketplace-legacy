module SupplyTeachers
  module Admin
    class CurrentData < ApplicationRecord
      self.abstract_class = true

      validate :only_one_record, on: :create

      # input files on both frameworks
      has_one_attached :current_accredited_suppliers
      has_one_attached :geographical_data_all_suppliers
      has_one_attached :master_vendor_contacts
      has_one_attached :pricing_for_tool
      has_one_attached :supplier_lookup

      # output file
      has_one_attached :data

      private

      def only_one_record
        errors.add(:base, 'You can only have one Current Data.') if self.class.unscoped.count >= 1
      end
    end
  end
end
