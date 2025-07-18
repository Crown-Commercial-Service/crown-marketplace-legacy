class AddJurisdictionToRates < ActiveRecord::Migration[8.0]
  class SupplierFrameworkLot < ApplicationRecord
    self.table_name = 'supplier_framework_lots'
  end

  class SupplierFrameworkLotJurisdictions < ApplicationRecord
    self.table_name = 'supplier_framework_lot_jurisdictions'
  end

  class SupplierFrameworkLotRates < ApplicationRecord
    self.table_name = 'supplier_framework_lot_rates'
  end

  def up
    add_reference :supplier_framework_lot_rates, :supplier_framework_lot_jurisdiction, type: :uuid, null: true, foreign_key: true

    SupplierFrameworkLotRates.reset_column_information

    SupplierFrameworkLot.find_each do |supplier_framework_lot|
      supplier_framework_lot_jurisdiction = SupplierFrameworkLotJurisdictions.create(supplier_framework_lot_id: supplier_framework_lot.id, jurisdiction_id: 'GB')

      # rubocop:disable Rails/SkipsModelValidations
      SupplierFrameworkLotRates.where(supplier_framework_lot_id: supplier_framework_lot.id).update_all(supplier_framework_lot_jurisdiction_id: supplier_framework_lot_jurisdiction.id)
      # rubocop:enable Rails/SkipsModelValidations
    end

    change_column :supplier_framework_lot_rates, :supplier_framework_lot_jurisdiction_id, :uuid, null: false

    remove_index :supplier_framework_lot_rates, column: %i[supplier_framework_lot_id position_id]
    add_index :supplier_framework_lot_rates, %i[supplier_framework_lot_id position_id supplier_framework_lot_jurisdiction_id], unique: true
  end

  def down
    remove_index :supplier_framework_lot_rates, column: %i[supplier_framework_lot_id position_id supplier_framework_lot_jurisdiction_id]
    add_index :supplier_framework_lot_rates, %i[supplier_framework_lot_id position_id], unique: true
    remove_reference :supplier_framework_lot_rates, :jurisdiction, null: true, foreign_key: true

    SupplierFrameworkLotJurisdictions.find_each(&:destroy)
  end
end
