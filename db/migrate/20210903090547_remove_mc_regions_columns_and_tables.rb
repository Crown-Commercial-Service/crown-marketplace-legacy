class RemoveMcRegionsColumnsAndTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :management_consultancy_admin_uploads, :supplier_regional_offerings_file, type: :string, limit: 255

    drop_table 'management_consultancy_regional_availabilities', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'management_consultancy_supplier_id', null: false
      t.text 'lot_number', null: false
      t.text 'region_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.boolean 'expenses_required', null: false
      t.index ['management_consultancy_supplier_id'], name: 'index_mc_regional_availabilities_on_mc_supplier_id'
      t.index ['region_code', 'lot_number', 'management_consultancy_supplier_id'], name: 'index_region_on_lot_number_and_mc_supplier_id', unique: true
    end
  end
end
