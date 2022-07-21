module SupplyTeachers
  module RM6238
    module Admin
      class Upload < SupplyTeachers::Admin::Upload
        self.table_name = 'supply_teachers_rm6238_admin_uploads'

        ATTRIBUTES = %i[current_accredited_suppliers geographical_data_all_suppliers master_vendor_contacts education_technology_platform_contacts pricing_for_tool supplier_lookup].freeze

        # input files specific to this framework
        has_one_attached :education_technology_platform_contacts

        validates :education_technology_platform_contacts, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'text/csv', message: :wrong_content_type }, on: :create
      end
    end
  end
end
