class UpdateJurisdictions < ActiveRecord::Migration[8.0]
  def change
    remove_index :supplier_framework_lots, column: %i[supplier_framework_id lot_id jurisdiction_id], name: :idx_on_supplier_framework_id_lot_id_jurisdiction_id_9ddaa88450, unique: true
    remove_reference :supplier_framework_lots, :jurisdiction, type: :text, foreign_key: true, index: true, null: true

    add_index :supplier_framework_lots, %i[supplier_framework_id lot_id], unique: true

    create_table :supplier_framework_lot_jurisdictions, id: :uuid do |t|
      t.references :supplier_framework_lot, type: :uuid, foreign_key: true, index: true, null: false
      t.references :jurisdiction, type: :text, foreign_key: true, index: true, null: false

      t.timestamps

      t.index %i[supplier_framework_lot_id jurisdiction_id], unique: true
    end
  end
end
