class RemoveNutsTables < ActiveRecord::Migration[7.1]
  def change
    drop_table 'nuts_regions', id: false, force: :cascade do |t|
      t.string 'code', limit: 255
      t.string 'name', limit: 255
      t.string 'nuts1_code', limit: 255
      t.string 'nuts2_code', limit: 255
      t.index ['code'], name: 'nuts_regions_code_key', unique: true
    end
  end
end
