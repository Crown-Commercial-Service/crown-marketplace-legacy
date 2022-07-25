class AddLegalServicesTables < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/AbcSize
  def change
    create_table :legal_services_rm6240_suppliers, id: :uuid do |t|
      t.text :name, null: false
      t.text :email
      t.text :phone_number
      t.text :website
      t.text :address
      t.boolean :sme
      t.integer :duns
      t.text :lot_1_prospectus_link
      t.text :lot_2_prospectus_link
      t.text :lot_3_prospectus_link

      t.timestamps
    end

    create_table :legal_services_rm6240_service_offerings, id: :uuid do |t|
      t.references :legal_services_rm6240_supplier, type: :uuid, foreign_key: true, index: { name: :index_ls_rm6240_service_offerings_on_ls_rm6240_supplier_id }
      t.string :service_code, limit: 4, null: false
      t.string :jurisdiction, limit: 1
      t.index %i[legal_services_rm6240_supplier_id service_code jurisdiction], unique: true, name: :index_rates_on_supplier_id_and_service_code_and_jurisdiction

      t.timestamps
    end

    create_table :legal_services_rm6240_rates, id: :uuid do |t|
      t.references :legal_services_rm6240_supplier, type: :uuid, foreign_key: true, index: { name: :index_ls_rm6240_rates_on_ls_rm6240_supplier_id }
      t.string :lot_number, limit: 1, null: false
      t.string :jurisdiction, limit: 1
      t.string :position, limit: 1, null: false
      t.integer :rate, null: false
      t.index %i[legal_services_rm6240_supplier_id lot_number jurisdiction position], unique: true, name: :index_rates_on_supplier_id_lot_number_position_jurisdiction

      t.timestamps
    end
  end
  # rubocop:enable Metrics/AbcSize
end
