class RemoveLegalServicesRM3788 < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def change
    drop_table 'legal_services_rm3788_admin_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'aasm_state', limit: 30
      t.string 'supplier_details_file', limit: 255
      t.string 'supplier_lot_1_service_offerings_file', limit: 255
      t.string 'supplier_lot_2_service_offerings_file', limit: 255
      t.string 'supplier_lot_3_service_offerings_file', limit: 255
      t.string 'supplier_lot_4_service_offerings_file', limit: 255
      t.string 'supplier_rate_cards_file', limit: 255
      t.text 'import_errors'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    drop_table 'legal_services_rm3788_regional_availabilities', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'legal_services_rm3788_supplier_id', null: false
      t.text 'region_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.text 'service_code'
      t.index ['legal_services_rm3788_supplier_id'], name: 'index_ls_rm3788_regional_availabilities_on_ls_supplier_id'
      t.index ['service_code', 'region_code', 'legal_services_rm3788_supplier_id'], name: 'index_service_on_region_and_ls_rm3788_supplier_id', unique: true
    end

    drop_table 'legal_services_rm3788_service_offerings', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'legal_services_rm3788_supplier_id', null: false
      t.text 'lot_number', null: false
      t.text 'service_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['legal_services_rm3788_supplier_id'], name: 'index_ls_rm3788_service_offerings_on_ls_supplier_id'
      t.index ['service_code', 'lot_number', 'legal_services_rm3788_supplier_id'], name: 'index_service_on_lot_number_and_ls_rm3788_supplier_id', unique: true
    end

    drop_table 'legal_services_rm3788_suppliers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.text 'name', null: false
      t.text 'email'
      t.text 'phone_number'
      t.text 'website'
      t.text 'address'
      t.boolean 'sme'
      t.integer 'duns'
      t.text 'lot_1_prospectus_link'
      t.text 'lot_2_prospectus_link'
      t.text 'lot_3_prospectus_link'
      t.text 'lot_4_prospectus_link'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.jsonb 'rate_cards'
      t.index ['rate_cards'], name: 'index_ls_rm3788_suppliers_on_rate_cards', using: :gin
    end

    drop_table 'legal_services_rm3788_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
