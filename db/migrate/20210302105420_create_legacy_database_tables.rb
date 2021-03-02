class CreateLegacyDatabaseTables < ActiveRecord::Migration[5.2]
  # rubocop:disable all
  def change
    create_table 'active_storage_attachments' do |t|
      t.string 'name', null: false
      t.string 'record_type', null: false
      t.bigint 'blob_id', null: false
      t.datetime 'created_at', null: false
      t.uuid 'record_id'
      t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    end

    create_table 'active_storage_blobs' do |t|
      t.string 'key', null: false
      t.string 'filename', null: false
      t.string 'content_type'
      t.text 'metadata'
      t.bigint 'byte_size', null: false
      t.string 'checksum', null: false
      t.datetime 'created_at', null: false
      t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
    end

    create_table 'legal_services_admin_uploads', id: :uuid do |t|
      t.string 'aasm_state', limit: 15
      t.string 'suppliers', limit: 255
      t.string 'supplier_lot_1_service_offerings', limit: 255
      t.string 'supplier_lot_2_service_offerings', limit: 255
      t.string 'supplier_lot_3_service_offerings', limit: 255
      t.string 'supplier_lot_4_service_offerings', limit: 255
      t.string 'rate_cards', limit: 255
      t.jsonb 'data'
      t.text 'fail_reason'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'suppliers_data'
    end

    create_table 'legal_services_regional_availabilities', id: :uuid do |t|
      t.uuid 'legal_services_supplier_id', null: false
      t.text 'region_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'service_code'
      t.index ['legal_services_supplier_id'], name: 'index_ls_regional_availabilities_on_ls_supplier_id'
    end

    create_table 'legal_services_service_offerings', id: :uuid do |t|
      t.uuid 'legal_services_supplier_id', null: false
      t.text 'lot_number', null: false
      t.text 'service_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['legal_services_supplier_id'], name: 'index_ls_service_offerings_on_ls_supplier_id'
    end

    create_table 'legal_services_suppliers', id: :uuid do |t|
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
      t.index ['rate_cards'], name: 'index_legal_services_suppliers_on_rate_cards', using: :gin
    end

    create_table 'legal_services_uploads', id: :uuid do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'management_consultancy_admin_uploads', id: :uuid do |t|
      t.string 'aasm_state', limit: 15
      t.text 'fail_reason'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'suppliers_data'
    end

    create_table 'management_consultancy_rate_cards', id: :uuid do |t|
      t.uuid 'management_consultancy_supplier_id', null: false
      t.string 'lot'
      t.integer 'junior_rate_in_pence'
      t.integer 'standard_rate_in_pence'
      t.integer 'senior_rate_in_pence'
      t.integer 'principal_rate_in_pence'
      t.integer 'managing_rate_in_pence'
      t.integer 'director_rate_in_pence'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'contact_name'
      t.string 'telephone_number'
      t.string 'email'
      t.index ['management_consultancy_supplier_id'], name: 'index_management_consultancy_rate_cards_on_supplier_id'
    end

    create_table 'management_consultancy_regional_availabilities', id: :uuid do |t|
      t.uuid 'management_consultancy_supplier_id', null: false
      t.text 'lot_number', null: false
      t.text 'region_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.boolean 'expenses_required', null: false
      t.index ['management_consultancy_supplier_id'], name: 'index_mc_regional_availabilities_on_mc_supplier_id'
    end

    create_table 'management_consultancy_service_offerings', id: :uuid do |t|
      t.uuid 'management_consultancy_supplier_id', null: false
      t.text 'lot_number', null: false
      t.text 'service_code', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['management_consultancy_supplier_id'], name: 'index_mc_service_offerings_on_mc_supplier_id'
    end

    create_table 'management_consultancy_suppliers', id: :uuid do |t|
      t.text 'name', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.text 'contact_name'
      t.text 'contact_email'
      t.text 'telephone_number'
      t.boolean 'sme'
      t.string 'address'
      t.string 'website'
      t.integer 'duns'
    end

    create_table 'management_consultancy_uploads', id: :uuid do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'nuts_regions', id: false do |t|
      t.string 'code', limit: 255
      t.string 'name', limit: 255
      t.string 'nuts1_code', limit: 255
      t.string 'nuts2_code', limit: 255
      t.index ['code'], name: 'nuts_regions_code_key', unique: true
    end

    create_table 'supply_teachers_admin_current_data' do |t|
      t.string 'current_accredited_suppliers', limit: 255
      t.string 'geographical_data_all_suppliers', limit: 255
      t.string 'lot_1_and_lot_2_comparisons', limit: 255
      t.string 'master_vendor_contacts', limit: 255
      t.string 'neutral_vendor_contacts', limit: 255
      t.string 'pricing_for_tool', limit: 255
      t.string 'supplier_lookup', limit: 255
      t.string 'data', limit: 255
      t.text 'error'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'supply_teachers_admin_uploads', id: :uuid do |t|
      t.string 'aasm_state', limit: 15
      t.string 'current_accredited_suppliers', limit: 255
      t.string 'geographical_data_all_suppliers', limit: 255
      t.string 'lot_1_and_lot_2_comparisons', limit: 255
      t.string 'master_vendor_contacts', limit: 255
      t.string 'neutral_vendor_contacts', limit: 255
      t.string 'pricing_for_tool', limit: 255
      t.string 'supplier_lookup', limit: 255
      t.text 'fail_reason'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'supply_teachers_branches', id: :uuid do |t|
      t.uuid 'supply_teachers_supplier_id', null: false
      t.string 'postcode', limit: 8, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.geography 'location', limit: { srid: 4326, type: 'st_point', geographic: true }
      t.text 'contact_name'
      t.text 'contact_email'
      t.text 'telephone_number'
      t.text 'name'
      t.text 'town'
      t.string 'address_1'
      t.string 'address_2'
      t.string 'county'
      t.string 'region'
      t.string 'slug'
      t.index ['slug'], name: 'index_supply_teachers_branches_on_slug', unique: true
      t.index ['supply_teachers_supplier_id'], name: 'index_supply_teachers_branches_on_supply_teachers_supplier_id'
    end

    create_table 'supply_teachers_rates', id: :uuid do |t|
      t.uuid 'supply_teachers_supplier_id', null: false
      t.text 'job_type', null: false
      t.float 'mark_up'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.text 'term'
      t.integer 'lot_number', default: 1, null: false
      t.money 'daily_fee', scale: 2
      t.index ['supply_teachers_supplier_id'], name: 'index_supply_teachers_rates_on_supply_teachers_supplier_id'
    end

    create_table 'supply_teachers_suppliers', id: :uuid do |t|
      t.text 'name', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.text 'neutral_vendor_contact_name'
      t.text 'neutral_vendor_telephone_number'
      t.text 'neutral_vendor_contact_email'
      t.text 'master_vendor_contact_name'
      t.text 'master_vendor_telephone_number'
      t.text 'master_vendor_contact_email'
    end

    create_table 'supply_teachers_uploads', id: :uuid do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'users', id: :uuid do |t|
      t.string 'email', limit: 255, default: '', null: false
      t.string 'first_name', limit: 255
      t.string 'last_name', limit: 255
      t.string 'phone_number', limit: 255
      t.string 'mobile_number', limit: 255
      t.datetime 'confirmed_at'
      t.string 'cognito_uuid', limit: 255
      t.integer 'roles_mask'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'session_token', limit: 255
      t.index ['email'], name: 'index_users_on_email', unique: true
      t.index ['session_token'], name: 'index_users_on_session_token'
    end

    add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
    add_foreign_key 'legal_services_regional_availabilities', 'legal_services_suppliers'
    add_foreign_key 'legal_services_service_offerings', 'legal_services_suppliers'
    add_foreign_key 'management_consultancy_rate_cards', 'management_consultancy_suppliers'
    add_foreign_key 'management_consultancy_regional_availabilities', 'management_consultancy_suppliers'
    add_foreign_key 'management_consultancy_service_offerings', 'management_consultancy_suppliers'
    add_foreign_key 'supply_teachers_branches', 'supply_teachers_suppliers'
    add_foreign_key 'supply_teachers_rates', 'supply_teachers_suppliers'
  end
  # rubocop:enable all
end
