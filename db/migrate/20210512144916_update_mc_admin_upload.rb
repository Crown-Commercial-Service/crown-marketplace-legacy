class UpdateMcAdminUpload < ActiveRecord::Migration[6.0]
  class MCAdminUpload < ApplicationRecord
    self.table_name = 'management_consultancy_admin_uploads'
  end

  def up
    MCAdminUpload.reset_column_information
    MCAdminUpload.destroy_all

    add_column :management_consultancy_admin_uploads, :supplier_details_file, :string, limit: 255
    add_column :management_consultancy_admin_uploads, :supplier_rate_cards_file, :string, limit: 255
    add_column :management_consultancy_admin_uploads, :supplier_regional_offerings_file, :string, limit: 255
    add_column :management_consultancy_admin_uploads, :supplier_service_offerings_file, :string, limit: 255
    add_column :management_consultancy_admin_uploads, :import_errors, :text
    change_column :management_consultancy_admin_uploads, :aasm_state, :string, limit: 30

    remove_column :management_consultancy_admin_uploads, :fail_reason
    remove_column :management_consultancy_admin_uploads, :suppliers_data
  end

  def down
    MCAdminUpload.reset_column_information
    MCAdminUpload.destroy_all

    remove_column :management_consultancy_admin_uploads, :supplier_details_file
    remove_column :management_consultancy_admin_uploads, :supplier_rate_cards_file
    remove_column :management_consultancy_admin_uploads, :supplier_regional_offerings_file
    remove_column :management_consultancy_admin_uploads, :supplier_service_offerings_file
    remove_column :management_consultancy_admin_uploads, :import_errors
    change_column :management_consultancy_admin_uploads, :aasm_state, :string, limit: 15

    add_column :management_consultancy_admin_uploads, :fail_reason, :text
    add_column :management_consultancy_admin_uploads, :suppliers_data, :string
  end
end
