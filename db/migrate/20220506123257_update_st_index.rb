class UpdateStIndex < ActiveRecord::Migration[6.0]
  INDEXES = [
    %i[supply_teachers_branches index_supply_teachers_branches_on_slug index_st_rm3826_branches_on_slug slug],
    %i[supply_teachers_branches index_supply_teachers_branches_on_supply_teachers_supplier_id index_st_rm3826_branches_on_st_supplier_id supply_teachers_supplier_id],
    %i[supply_teachers_rates index_lot_number_on_term_and_job_type_and_st_supplier_id index_lot_number_on_term_and_job_type_and_st_rm3826_supplier_id lot_number term job_type supply_teachers_supplier_id],
    %i[supply_teachers_rates index_supply_teachers_rates_on_supply_teachers_supplier_id index_st_rm3826_rates_on_st_supplier_id supply_teachers_supplier_id]
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
