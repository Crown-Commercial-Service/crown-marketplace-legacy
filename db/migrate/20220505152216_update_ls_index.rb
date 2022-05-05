class UpdateLsIndex < ActiveRecord::Migration[6.0]
  INDEXES = [
    %i[legal_services_regional_availabilities index_ls_regional_availabilities_on_ls_supplier_id index_ls_rm3788_regional_availabilities_on_ls_supplier_id legal_services_supplier_id],
    %i[legal_services_regional_availabilities index_service_on_region_and_ls_supplier_id index_service_on_region_and_ls_rm3788_supplier_id service_code],
    %i[legal_services_service_offerings index_ls_service_offerings_on_ls_supplier_id index_ls_rm3788_service_offerings_on_ls_supplier_id legal_services_supplier_id],
    %i[legal_services_service_offerings index_service_on_lot_number_and_ls_supplier_id index_service_on_lot_number_and_ls_rm3788_supplier_id service_code],
    %i[legal_services_suppliers index_legal_services_suppliers_on_rate_cards index_ls_rm3788_suppliers_on_rate_cards rate_cards]
  ].freeze

  def up
    INDEXES.each do |table_name, old_index, new_index, column|
      rename_index table_name, old_index, new_index if ActiveRecord::Base.connection.index_exists?(table_name, column, name: old_index)
    end
  end

  def down
    INDEXES.each do |table_name, old_index, new_index, column|
      rename_index table_name, new_index, old_index if ActiveRecord::Base.connection.index_exists?(table_name, column, name: new_index)
    end
  end
end
