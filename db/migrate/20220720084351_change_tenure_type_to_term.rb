class ChangeTenureTypeToTerm < ActiveRecord::Migration[6.0]
  def change
    rename_column :supply_teachers_rm6238_rates, :tenure_type, :term
  end
end
