class AddMcf4Tables < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/AbcSize
  def change
    create_table :management_consultancy_rm6309_suppliers, id: :uuid do |t|
      t.text :name, null: false
      t.text :contact_name
      t.text :contact_email
      t.text :telephone_number
      t.boolean :sme
      t.text :address
      t.text :website
      t.integer :duns

      t.timestamps
    end

    create_table :management_consultancy_rm6309_lot_contact_details, id: :uuid do |t|
      t.references :management_consultancy_rm6309_supplier, type: :uuid, foreign_key: true, index: { name: :index_mc_rm6309_lot_contact_details_on_supplier_id }
      t.text :lot
      t.text :contact_name
      t.text :telephone_number
      t.text :email

      t.timestamps

      t.index %i[lot management_consultancy_rm6309_supplier_id], name: :index_rm6309_lot_on_mc_supplier_id, unique: true
    end

    create_table :management_consultancy_rm6309_rate_cards, id: :uuid do |t|
      t.references :management_consultancy_rm6309_supplier, type: :uuid, foreign_key: true, index: { name: :index_mc_rm6309_rate_cards_on_supplier_id }
      t.text :lot
      t.text :rate_type
      t.integer :junior_rate_in_pence
      t.integer :standard_rate_in_pence
      t.integer :senior_rate_in_pence
      t.integer :principal_rate_in_pence
      t.integer :managing_rate_in_pence
      t.integer :director_rate_in_pence

      t.timestamps

      t.index %i[lot rate_type management_consultancy_rm6309_supplier_id], name: :index_rm6309_lot_on_type_and_mc_supplier_id, unique: true
    end

    create_table :management_consultancy_rm6309_service_offerings, id: :uuid do |t|
      t.references :management_consultancy_rm6309_supplier, type: :uuid, foreign_key: true, index: { name: :index_mc_rm6309_service_offerings_on_mc_supplier_id }
      t.text :lot_number, null: false
      t.text :service_code, null: false

      t.timestamps

      t.index %i[service_code lot_number management_consultancy_rm6309_supplier_id], name: :index_rm6309_service_on_lot_number_and_mc_supplier_id, unique: true
    end

    create_table :management_consultancy_rm6309_admin_uploads, id: :uuid do |t|
      t.string :aasm_state, limit: 30
      t.text :import_errors

      t.timestamps
    end

    create_table :management_consultancy_rm6309_uploads, id: :uuid, &:timestamps
  end
  # rubocop:enable Metrics/AbcSize
end
