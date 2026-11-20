class AddServiceIdToSupplierFrameworkLotRates < ActiveRecord::Migration[8.1]
  def change
    add_reference :supplier_framework_lot_rates, :service,
                  foreign_key: true,
                  type: :string,
                  null: true

    add_index :supplier_framework_lot_rates,
              %i[supplier_framework_lot_id position_id service_id],
              unique: true
  end
end
