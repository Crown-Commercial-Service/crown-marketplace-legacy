class AddFrameworkToMcTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :management_consultancy_admin_uploads,     :management_consultancy_rm6187_admin_uploads
    rename_table :management_consultancy_rate_cards,        :management_consultancy_rm6187_rate_cards
    rename_table :management_consultancy_service_offerings, :management_consultancy_rm6187_service_offerings
    rename_table :management_consultancy_suppliers,         :management_consultancy_rm6187_suppliers
    rename_table :management_consultancy_uploads,           :management_consultancy_rm6187_uploads
  end
end
