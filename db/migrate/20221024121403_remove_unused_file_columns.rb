class RemoveUnusedFileColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :management_consultancy_rm6187_admin_uploads, :supplier_details_file, type: :string, limit: 255
    remove_column :management_consultancy_rm6187_admin_uploads, :supplier_rate_cards_file, type: :string, limit: 255
    remove_column :management_consultancy_rm6187_admin_uploads, :supplier_service_offerings_file, type: :string, limit: 255
  end
end
