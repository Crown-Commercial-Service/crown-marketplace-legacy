module ManagementConsultancy
  module RM6309
    module Admin
      class Upload < ::Admin::Upload
        self.table_name = 'management_consultancy_rm6309_admin_uploads'

        has_one_attached :supplier_details_file
        has_one_attached :supplier_rate_cards_file
        has_one_attached :supplier_service_offerings_file

        validates :supplier_details_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload
        validates :supplier_rate_cards_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload
        validates :supplier_service_offerings_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload

        def self.attributes
          %i[supplier_details_file supplier_rate_cards_file supplier_service_offerings_file]
        end
      end
    end
  end
end
