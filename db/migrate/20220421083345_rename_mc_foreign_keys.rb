class RenameMcForeignKeys < ActiveRecord::Migration[6.0]
  def change
    rename_column :management_consultancy_rm6187_rate_cards,        :management_consultancy_supplier_id, :management_consultancy_rm6187_supplier_id
    rename_column :management_consultancy_rm6187_service_offerings, :management_consultancy_supplier_id, :management_consultancy_rm6187_supplier_id
  end
end
