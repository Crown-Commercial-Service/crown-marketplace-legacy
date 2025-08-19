class RemoveOldSupplierDataTables < ActiveRecord::Migration[8.0]
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Migration/RequireLimitOnString
  def change
    drop_table 'legal_services_rm6240_rates', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'legal_services_rm6240_supplier_id'
      t.string 'lot_number', limit: 1, null: false
      t.string 'jurisdiction', limit: 1
      t.string 'position', limit: 1, null: false
      t.integer 'rate', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['legal_services_rm6240_supplier_id', 'lot_number', 'jurisdiction', 'position'], name: 'index_rates_on_supplier_id_lot_number_position_jurisdiction', unique: true
      t.index ['legal_services_rm6240_supplier_id'], name: 'index_ls_rm6240_rates_on_ls_rm6240_supplier_id'
    end

    drop_table 'legal_services_rm6240_service_offerings', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'legal_services_rm6240_supplier_id'
      t.string 'service_code', limit: 4, null: false
      t.string 'jurisdiction', limit: 1
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['legal_services_rm6240_supplier_id', 'service_code', 'jurisdiction'], name: 'index_rates_on_supplier_id_and_service_code_and_jurisdiction', unique: true
      t.index ['legal_services_rm6240_supplier_id'], name: 'index_ls_rm6240_service_offerings_on_ls_rm6240_supplier_id'
    end

    drop_table 'legal_services_rm6240_suppliers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
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
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    drop_table 'legal_services_rm6240_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    drop_table 'management_consultancy_rm6187_rate_cards', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'management_consultancy_rm6187_supplier_id', null: false
      t.string 'lot'
      t.integer 'junior_rate_in_pence'
      t.integer 'standard_rate_in_pence'
      t.integer 'senior_rate_in_pence'
      t.integer 'principal_rate_in_pence'
      t.integer 'managing_rate_in_pence'
      t.integer 'director_rate_in_pence'
      t.datetime 'created_at', precision: nil, null: false
      t.datetime 'updated_at', precision: nil, null: false
      t.string 'contact_name'
      t.string 'telephone_number'
      t.string 'email'
      t.index ['management_consultancy_rm6187_supplier_id'], name: 'index_mc_rm6187_rate_cards_on_supplier_id'
    end

    drop_table 'management_consultancy_rm6187_service_offerings', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'management_consultancy_rm6187_supplier_id', null: false
      t.text 'lot_number', null: false
      t.text 'service_code', null: false
      t.datetime 'created_at', precision: nil, null: false
      t.datetime 'updated_at', precision: nil, null: false
      t.index ['management_consultancy_rm6187_supplier_id'], name: 'index_mc_rm6187_service_offerings_on_mc_supplier_id'
      t.index ['service_code', 'lot_number', 'management_consultancy_rm6187_supplier_id'], name: 'index_rm6187_service_on_lot_number_and_mc_supplier_id', unique: true
    end

    drop_table 'management_consultancy_rm6187_suppliers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.text 'name', null: false
      t.datetime 'created_at', precision: nil, null: false
      t.datetime 'updated_at', precision: nil, null: false
      t.text 'contact_name'
      t.text 'contact_email'
      t.text 'telephone_number'
      t.boolean 'sme'
      t.string 'address'
      t.string 'website'
      t.integer 'duns'
    end

    drop_table 'management_consultancy_rm6187_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.datetime 'created_at', precision: nil, null: false
      t.datetime 'updated_at', precision: nil, null: false
    end

    drop_table 'management_consultancy_rm6309_rate_cards', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'management_consultancy_rm6309_supplier_id'
      t.text 'lot'
      t.text 'rate_type'
      t.integer 'junior_rate_in_pence'
      t.integer 'standard_rate_in_pence'
      t.integer 'senior_rate_in_pence'
      t.integer 'principal_rate_in_pence'
      t.integer 'managing_rate_in_pence'
      t.integer 'director_rate_in_pence'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['lot', 'rate_type', 'management_consultancy_rm6309_supplier_id'], name: 'index_rm6309_lot_on_type_and_mc_supplier_id', unique: true
      t.index ['management_consultancy_rm6309_supplier_id'], name: 'index_mc_rm6309_rate_cards_on_supplier_id'
    end

    drop_table 'management_consultancy_rm6309_service_offerings', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'management_consultancy_rm6309_supplier_id'
      t.text 'lot_number', null: false
      t.text 'service_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['management_consultancy_rm6309_supplier_id'], name: 'index_mc_rm6309_service_offerings_on_mc_supplier_id'
      t.index ['service_code', 'lot_number', 'management_consultancy_rm6309_supplier_id'], name: 'index_rm6309_service_on_lot_number_and_mc_supplier_id', unique: true
    end

    drop_table 'management_consultancy_rm6309_suppliers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.text 'name', null: false
      t.text 'contact_name'
      t.text 'contact_email'
      t.text 'telephone_number'
      t.boolean 'sme'
      t.text 'address'
      t.text 'website'
      t.integer 'duns'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    drop_table 'management_consultancy_rm6309_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    drop_table 'supply_teachers_rm6238_branches', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'supply_teachers_rm6238_supplier_id'
      t.text 'slug'
      t.geography 'location', limit: { srid: 4326, type: 'st_point', geographic: true }
      t.string 'postcode', limit: 8, null: false
      t.text 'contact_name'
      t.text 'contact_email'
      t.text 'telephone_number'
      t.text 'name'
      t.text 'town'
      t.text 'address_1'
      t.text 'address_2'
      t.text 'county'
      t.text 'region'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['slug'], name: 'index_supply_teachers_rm6238_branches_on_slug'
      t.index ['supply_teachers_rm6238_supplier_id'], name: 'index_st_rm6238_branches_on_st_rm6238_supplier_id'
    end

    drop_table 'supply_teachers_rm6238_managed_service_providers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'supply_teachers_rm6238_supplier_id'
      t.string 'lot_number', limit: 4, null: false
      t.text 'contact_name'
      t.text 'telephone_number'
      t.text 'contact_email'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['lot_number'], name: 'index_st_rm6238_managed_service_providers_on_lot_number'
      t.index ['supply_teachers_rm6238_supplier_id'], name: 'index_st_rm6238_service_providers_on_st_rm6238_supplier_id'
    end

    drop_table 'supply_teachers_rm6238_rates', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'supply_teachers_rm6238_supplier_id'
      t.string 'lot_number', limit: 4, null: false
      t.integer 'rate', null: false
      t.text 'job_type', null: false
      t.text 'term'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['supply_teachers_rm6238_supplier_id', 'lot_number', 'job_type', 'term'], name: 'index_rates_on_supplier_id_and_lot_number_and_job_and_tenure', unique: true
      t.index ['supply_teachers_rm6238_supplier_id'], name: 'index_st_rm6238_rates_on_st_rm6238_supplier_id'
    end

    drop_table 'supply_teachers_rm6238_suppliers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.text 'name', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    drop_table 'supply_teachers_rm6238_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Migration/RequireLimitOnString
end
