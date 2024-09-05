class AddLotAndServiceTables < ActiveRecord::Migration[7.1]
  def change
    create_table :framework_lots, id: :string, limit: 100 do |t|
      t.references :framework, type: :string, foreign_key: true, null: false
      t.string :number, limit: 6, null: false, index: true
      t.text :name, null: false

      t.timestamps
    end

    create_table :framework_lot_services, id: :string, limit: 100 do |t|
      t.references :framework_lot, type: :string, foreign_key: true, null: false
      t.string :number, limit: 6, null: false, index: true
      t.text :name, null: false

      t.timestamps
    end

    create_table :regions, id: :string, limit: 6 do |t|
      t.text :name

      t.timestamps
    end
  end
end
