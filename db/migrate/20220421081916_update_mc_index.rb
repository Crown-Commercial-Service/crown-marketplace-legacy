class UpdateMcIndex < ActiveRecord::Migration[6.0]
  INDEXES = [
    %i[management_consultancy_rate_cards index_management_consultancy_rate_cards_on_supplier_id index_mc_rm6187_rate_cards_on_supplier_id management_consultancy_supplier_id],
    %i[management_consultancy_service_offerings index_mc_service_offerings_on_mc_supplier_id index_mc_rm6187_service_offerings_on_mc_supplier_id management_consultancy_supplier_id],
    %i[management_consultancy_service_offerings index_service_on_lot_number_and_mc_supplier_id index_rm6187_service_on_lot_number_and_mc_supplier_id service_code lot_number management_consultancy_supplier_id],
  ].freeze

  def up
    INDEXES.each do |table_name, old_index, new_index, *columns|
      rename_index table_name, old_index, new_index if ActiveRecord::Base.connection.index_exists?(table_name, columns, name: old_index)
    end
  end

  def down
    INDEXES.each do |table_name, old_index, new_index, *columns|
      rename_index table_name, new_index, old_index if ActiveRecord::Base.connection.index_exists?(table_name, columns, name: new_index)
    end
  end
end
