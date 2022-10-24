class RemoveSupplyTeachersRm3826 < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def change
    drop_table 'supply_teachers_rm3826_admin_current_data', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
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

    drop_table 'supply_teachers_rm3826_admin_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'aasm_state', limit: 30
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

    drop_table 'supply_teachers_rm3826_branches', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'supply_teachers_rm3826_supplier_id', null: false
      t.string 'postcode', limit: 8, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.geography 'location', limit: { srid: 4326, type: 'st_point', geographic: true }
      t.text 'contact_name'
      t.text 'contact_email'
      t.text 'telephone_number'
      t.text 'name'
      t.text 'town'
      t.text 'address_1'
      t.text 'address_2'
      t.text 'county'
      t.text 'region'
      t.text 'slug'
      t.index ['slug'], name: 'index_st_rm3826_branches_on_slug', unique: true
      t.index ['supply_teachers_rm3826_supplier_id'], name: 'index_st_rm3826_branches_on_st_supplier_id'
    end

    drop_table 'supply_teachers_rm3826_rates', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.uuid 'supply_teachers_rm3826_supplier_id', null: false
      t.text 'job_type', null: false
      t.float 'mark_up'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.text 'term'
      t.integer 'lot_number', default: 1, null: false
      t.money 'daily_fee', scale: 2
      t.index ['lot_number', 'term', 'job_type', 'supply_teachers_rm3826_supplier_id'], name: 'index_lot_number_on_term_and_job_type_and_st_rm3826_supplier_id', unique: true
      t.index ['supply_teachers_rm3826_supplier_id'], name: 'index_st_rm3826_rates_on_st_supplier_id'
    end

    drop_table 'supply_teachers_rm3826_suppliers', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
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

    drop_table 'supply_teachers_rm3826_uploads', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
