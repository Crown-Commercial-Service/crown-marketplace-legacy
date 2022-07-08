module SupplyTeachers
  module RM3826
    module Admin
      class Upload < SupplyTeachers::Admin::Upload
        self.table_name = 'supply_teachers_rm3826_admin_uploads'

        ATTRIBUTES = %i[current_accredited_suppliers geographical_data_all_suppliers lot_1_and_lot_2_comparisons master_vendor_contacts neutral_vendor_contacts pricing_for_tool supplier_lookup].freeze

        # input files specific to this framework
        has_one_attached :lot_1_and_lot_2_comparisons
        has_one_attached :neutral_vendor_contacts

        validates :lot_1_and_lot_2_comparisons, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :create
        validates :neutral_vendor_contacts, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'text/csv', message: :wrong_content_type }, on: :create
      end
    end
  end
end
