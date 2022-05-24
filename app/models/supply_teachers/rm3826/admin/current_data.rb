module SupplyTeachers
  module RM3826
    module Admin
      class CurrentData < ApplicationRecord
        self.table_name = 'supply_teachers_rm3826_admin_current_data'

        validate :only_one_record, on: :create

        # input files
        has_one_attached :current_accredited_suppliers
        has_one_attached :geographical_data_all_suppliers
        has_one_attached :lot_1_and_lot_2_comparisons
        has_one_attached :master_vendor_contacts
        has_one_attached :neutral_vendor_contacts
        has_one_attached :pricing_for_tool
        has_one_attached :supplier_lookup

        # output file
        has_one_attached :data

        private

        def only_one_record
          errors.add(:base, 'You can only have one Current Data.') if CurrentData.unscoped.all.count >= 1
        end
      end
    end
  end
end
