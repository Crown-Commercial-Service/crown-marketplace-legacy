module LegalPanelForGovernment
  module RM6360
    module Admin
      class Upload < ::Admin::Upload
        self.table_name = 'legal_panel_for_government_rm6360_admin_uploads'

        has_one_attached :supplier_details_file
        has_one_attached :supplier_service_offerings_file
        has_one_attached :supplier_other_lots_rate_cards_file
        has_one_attached :supplier_lot_4a_rate_cards_file
        has_one_attached :supplier_lot_4b_rate_cards_file
        has_one_attached :supplier_lot_4c_rate_cards_file

        validates :supplier_details_file, :supplier_service_offerings_file, :supplier_other_lots_rate_cards_file, :supplier_lot_4a_rate_cards_file, :supplier_lot_4b_rate_cards_file, :supplier_lot_4c_rate_cards_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload

        def self.attributes
          self::ATTRIBUTES
        end

        ATTRIBUTES = %i[supplier_details_file supplier_service_offerings_file supplier_other_lots_rate_cards_file supplier_lot_4a_rate_cards_file supplier_lot_4b_rate_cards_file supplier_lot_4c_rate_cards_file].freeze
      end
    end
  end
end
