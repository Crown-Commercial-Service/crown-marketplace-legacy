class AddFrameworkToStTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :supply_teachers_admin_current_data, :supply_teachers_rm3826_admin_current_data
    rename_table :supply_teachers_admin_uploads,      :supply_teachers_rm3826_admin_uploads
    rename_table :supply_teachers_branches,           :supply_teachers_rm3826_branches
    rename_table :supply_teachers_rates,              :supply_teachers_rm3826_rates
    rename_table :supply_teachers_suppliers,          :supply_teachers_rm3826_suppliers
    rename_table :supply_teachers_uploads,            :supply_teachers_rm3826_uploads
  end
end
