class UpdateLsTable < ActiveRecord::Migration[6.0]
  class LSAdminUpload < ApplicationRecord
    self.table_name = 'legal_services_admin_uploads'
  end

  def up
    LSAdminUpload.reset_column_information
    LSAdminUpload.destroy_all

    change_column :legal_services_admin_uploads, :aasm_state, :string, limit: 30

    rename_column :legal_services_admin_uploads, :suppliers, :supplier_details_file
    rename_column :legal_services_admin_uploads, :rate_cards, :supplier_rate_cards_file
    rename_column :legal_services_admin_uploads, :supplier_lot_1_service_offerings, :supplier_lot_1_service_offerings_file
    rename_column :legal_services_admin_uploads, :supplier_lot_2_service_offerings, :supplier_lot_2_service_offerings_file
    rename_column :legal_services_admin_uploads, :supplier_lot_3_service_offerings, :supplier_lot_3_service_offerings_file
    rename_column :legal_services_admin_uploads, :supplier_lot_4_service_offerings, :supplier_lot_4_service_offerings_file
    rename_column :legal_services_admin_uploads, :fail_reason, :import_errors

    remove_column :legal_services_admin_uploads, :data
    remove_column :legal_services_admin_uploads, :suppliers_data
  end

  def down
    LSAdminUpload.reset_column_information
    LSAdminUpload.destroy_all

    change_column :legal_services_admin_uploads, :aasm_state, :string, limit: 15

    rename_column :legal_services_admin_uploads, :supplier_details_file, :suppliers
    rename_column :legal_services_admin_uploads, :supplier_rate_cards_file, :rate_cards
    rename_column :legal_services_admin_uploads, :supplier_lot_1_service_offerings_file, :supplier_lot_1_service_offerings
    rename_column :legal_services_admin_uploads, :supplier_lot_2_service_offerings_file, :supplier_lot_2_service_offerings
    rename_column :legal_services_admin_uploads, :supplier_lot_3_service_offerings_file, :supplier_lot_3_service_offerings
    rename_column :legal_services_admin_uploads, :supplier_lot_4_service_offerings_file, :supplier_lot_4_service_offerings
    rename_column :legal_services_admin_uploads, :import_errors, :fail_reason

    add_column :legal_services_admin_uploads, :data, :jsonb
    add_column :legal_services_admin_uploads, :suppliers_data, :string
  end
end
