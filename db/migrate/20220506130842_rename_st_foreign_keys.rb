class RenameStForeignKeys < ActiveRecord::Migration[6.0]
  def change
    rename_column :supply_teachers_rm3826_branches, :supply_teachers_supplier_id, :supply_teachers_rm3826_supplier_id
    rename_column :supply_teachers_rm3826_rates,    :supply_teachers_supplier_id, :supply_teachers_rm3826_supplier_id
  end
end
