class AddFrameworkToLsTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :legal_services_admin_uploads,           :legal_services_rm3788_admin_uploads
    rename_table :legal_services_regional_availabilities, :legal_services_rm3788_regional_availabilities
    rename_table :legal_services_service_offerings,       :legal_services_rm3788_service_offerings
    rename_table :legal_services_suppliers,               :legal_services_rm3788_suppliers
    rename_table :legal_services_uploads,                 :legal_services_rm3788_uploads
  end
end
