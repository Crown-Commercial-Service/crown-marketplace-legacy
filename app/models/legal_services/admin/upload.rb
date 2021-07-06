module LegalServices
  module Admin
    class Upload < ::Admin::Upload
      self.table_name = 'legal_services_admin_uploads'

      has_one_attached :supplier_details_file
      has_one_attached :supplier_rate_cards_file
      has_one_attached :supplier_lot_1_service_offerings_file
      has_one_attached :supplier_lot_2_service_offerings_file
      has_one_attached :supplier_lot_3_service_offerings_file
      has_one_attached :supplier_lot_4_service_offerings_file

      validates :supplier_details_file, :supplier_rate_cards_file, :supplier_lot_1_service_offerings_file, :supplier_lot_2_service_offerings_file, :supplier_lot_3_service_offerings_file, :supplier_lot_4_service_offerings_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload

      def self.attributes
        self::ATTRIBUTES
      end

      ATTRIBUTES = %i[supplier_details_file supplier_rate_cards_file supplier_lot_1_service_offerings_file supplier_lot_2_service_offerings_file supplier_lot_3_service_offerings_file supplier_lot_4_service_offerings_file].freeze
      SERVICE = LegalServices
    end
  end
end
