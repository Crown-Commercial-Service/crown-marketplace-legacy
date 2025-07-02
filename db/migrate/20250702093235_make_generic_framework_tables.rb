class MakeGenericFrameworkTables < ActiveRecord::Migration[8.0]
  def change
    create_table :lots, id: :text, force: :cascade do |t|
      t.references :framework, type: :text, foreign_key: true, index: true, null: false
      t.text :number, null: false
      t.text :name, null: false

      t.timestamps
    end

    create_table :services, id: :text, force: :cascade do |t|
      t.references :lot, type: :text, foreign_key: true, index: true, null: false
      t.text :number, null: false
      t.text :name, null: false
      t.text :category

      t.timestamps
    end
  end
end
