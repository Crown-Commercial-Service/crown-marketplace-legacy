class RenameLsForeignKeys < ActiveRecord::Migration[6.0]
  def change
    rename_column :legal_services_rm3788_regional_availabilities, :legal_services_supplier_id, :legal_services_rm3788_supplier_id
    rename_column :legal_services_rm3788_service_offerings,       :legal_services_supplier_id, :legal_services_rm3788_supplier_id
  end
end
