class CreateSectorsAndSupplierFrameworkSectors < ActiveRecord::Migration[8.1]
  def change
    create_table :sectors do |t|
      t.text :name, null: false
      t.timestamps
    end

    add_index :sectors, :name, unique: true

    create_table :supplier_framework_sectors do |t|
      t.references :supplier_framework,
                   type: :uuid,
                   null: false,
                   foreign_key: { to_table: :supplier_frameworks },
                   index: { name: 'idx_supp_fw_sectors_on_fw_id' }

      t.references :sector,
                   null: false,
                   foreign_key: true

      t.timestamps
    end

    add_index :supplier_framework_sectors,
              %i[supplier_framework_id sector_id],
              unique: true,
              name: 'idx_supp_fw_sectors_uniqueness'
  end
end
