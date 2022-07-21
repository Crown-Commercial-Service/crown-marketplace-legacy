class AddRM6238SupplierTables < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/AbcSize
  def change
    create_table :supply_teachers_rm6238_suppliers, id: :uuid do |t|
      t.text :name, null: false

      t.timestamps
    end

    create_table :supply_teachers_rm6238_managed_service_providers, id: :uuid do |t|
      t.references :supply_teachers_rm6238_supplier, type: :uuid, foreign_key: true, index: { name: 'index_st_rm6238_service_providers_on_st_rm6238_supplier_id' }
      t.string :lot_number, limit: 4, null: false, index: { name: 'index_st_rm6238_managed_service_providers_on_lot_number' }
      t.text :contact_name
      t.text :telephone_number
      t.text :contact_email

      t.timestamps
    end

    create_table :supply_teachers_rm6238_branches, id: :uuid do |t|
      t.references :supply_teachers_rm6238_supplier, type: :uuid, foreign_key: true, index: { name: 'index_st_rm6238_branches_on_st_rm6238_supplier_id' }
      t.text :slug, index: true
      t.geography :location, limit: { srid: 4326, type: :st_point, geographic: true }
      t.string :postcode, limit: 8, null: false
      t.text :contact_name
      t.text :contact_email
      t.text :telephone_number
      t.text :name
      t.text :town
      t.text :address_1
      t.text :address_2
      t.text :county
      t.text :region

      t.timestamps
    end

    create_table :supply_teachers_rm6238_rates, id: :uuid do |t|
      t.references :supply_teachers_rm6238_supplier, type: :uuid, foreign_key: true, index: { name: 'index_st_rm6238_rates_on_st_rm6238_supplier_id' }
      t.string :lot_number, limit: 4, null: false
      t.integer :rate, null: false
      t.text :job_type, null: false
      t.text :tenure_type
      t.index %i[supply_teachers_rm6238_supplier_id lot_number job_type tenure_type], unique: true, name: :index_rates_on_supplier_id_and_lot_number_and_job_and_tenure

      t.timestamps
    end
  end
  # rubocop:enable Metrics/AbcSize
end
