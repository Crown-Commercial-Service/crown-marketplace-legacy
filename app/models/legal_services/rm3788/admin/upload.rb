module LegalServices
  module RM3788
    module Admin
      class Upload < LegalServices::Admin::Upload
        self.table_name = 'legal_services_rm3788_admin_uploads'

        has_one_attached :supplier_lot_4_service_offerings_file

        validates :supplier_lot_4_service_offerings_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload

        ATTRIBUTES = (SHARED_ATTRIBUTES + %i[supplier_lot_4_service_offerings_file]).freeze
      end
    end
  end
end
