class UpdateUniqueIndexOnSupplierFrameworkLotRates < ActiveRecord::Migration[8.1]
  def up
    remove_index :supplier_framework_lot_rates,
                 name: 'idx_on_supplier_framework_lot_id_position_id_suppli_ed53e87c0a',
                 if_exists: true

    remove_index :supplier_framework_lot_rates,
                 name: 'idx_on_supplier_framework_lot_id_position_id_servic_1a7f12fae2',
                 if_exists: true

    add_index :supplier_framework_lot_rates,
              %i[supplier_framework_lot_id position_id supplier_framework_lot_jurisdiction_id service_id],
              unique: true,
              name: 'idx_supplier_lot_rates_unique_with_service',
              if_not_exists: true
  end

  def down
    remove_index :supplier_framework_lot_rates,
                 name: 'idx_supplier_lot_rates_unique_with_service',
                 if_exists: true

    add_index :supplier_framework_lot_rates,
              %i[supplier_framework_lot_id position_id service_id],
              unique: true,
              name: 'idx_on_supplier_framework_lot_id_position_id_servic_1a7f12fae2',
              if_not_exists: true
  end
end
