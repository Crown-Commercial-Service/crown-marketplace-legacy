class AddMoreDetailsToPositions < ActiveRecord::Migration[8.0]
  def change
    change_table :positions, bulk: true do |t|
      t.text :rate_type
      t.boolean :mandetory
    end
  end
end
