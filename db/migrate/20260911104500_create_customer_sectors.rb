class CreateCustomerSectors < ActiveRecord::Migration[8.1]
  def change
    create_table :customer_sectors, id: :uuid do |t|
      t.string :name
      t.string :code
      t.timestamps
    end

    create_table :customer_sector_mappings, id: :uuid do |t|
      t.references :supplier_framework_contact_detail, type: :uuid, null: false, foreign_key: true, index: { name: 'idx_on_contact_detail_id' }
      t.references :customer_sector, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end