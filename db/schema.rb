# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_11_103945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"
  enable_extension "postgis"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.uuid "record_id"
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bank_holidays", force: :cascade do |t|
    t.text "title"
    t.date "date"
    t.text "notes"
    t.boolean "bunting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_bank_holidays_on_date"
  end

  create_table "frameworks", id: :text, force: :cascade do |t|
    t.text "service"
    t.date "live_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_at"
  end

  create_table "jurisdictions", id: :text, force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "mapping_name"
  end

  create_table "legal_panel_for_government_rm6360_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.text "import_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legal_services_rm6240_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.text "import_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lots", id: :text, force: :cascade do |t|
    t.text "framework_id", null: false
    t.text "number", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["framework_id"], name: "index_lots_on_framework_id"
  end

  create_table "management_consultancy_rm6187_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "import_errors"
  end

  create_table "management_consultancy_rm6309_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.text "import_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", id: :text, force: :cascade do |t|
    t.text "lot_id", null: false
    t.integer "number", null: false
    t.text "name", null: false
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_positions_on_lot_id"
  end

  create_table "reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "framework_id", null: false
    t.string "aasm_state", limit: 30
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["framework_id"], name: "index_reports_on_framework_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "searches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "framework_id", null: false
    t.uuid "session_id"
    t.text "search_criteria"
    t.text "search_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["framework_id"], name: "index_searches_on_framework_id"
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "services", id: :text, force: :cascade do |t|
    t.text "lot_id", null: false
    t.text "number", null: false
    t.text "name", null: false
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_services_on_lot_id"
  end

  create_table "supplier_framework_addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_id", null: false
    t.text "address_line_1"
    t.text "address_line_2"
    t.text "town"
    t.text "county"
    t.text "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_framework_id"], name: "index_supplier_framework_addresses_on_supplier_framework_id"
  end

  create_table "supplier_framework_contact_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_id", null: false
    t.text "name"
    t.text "email"
    t.text "telephone_number"
    t.text "website"
    t.jsonb "additional_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_framework_id"], name: "idx_on_supplier_framework_id_9cfb9d6920"
  end

  create_table "supplier_framework_lot_branches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_lot_id", null: false
    t.text "slug"
    t.geography "location", limit: {srid: 4326, type: "st_point", geographic: true}
    t.string "postcode", limit: 8, null: false
    t.text "contact_name"
    t.text "contact_email"
    t.text "telephone_number"
    t.text "name"
    t.text "town"
    t.text "address_line_1"
    t.text "address_line_2"
    t.text "county"
    t.text "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_supplier_framework_lot_branches_on_slug"
    t.index ["supplier_framework_lot_id"], name: "idx_on_supplier_framework_lot_id_5cc87a7153"
  end

  create_table "supplier_framework_lot_jurisdictions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_lot_id", null: false
    t.text "jurisdiction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jurisdiction_id"], name: "index_supplier_framework_lot_jurisdictions_on_jurisdiction_id"
    t.index ["supplier_framework_lot_id", "jurisdiction_id"], name: "idx_on_supplier_framework_lot_id_jurisdiction_id_bf241ce276", unique: true
    t.index ["supplier_framework_lot_id"], name: "idx_on_supplier_framework_lot_id_57bebdac3f"
  end

  create_table "supplier_framework_lot_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_lot_id", null: false
    t.integer "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "supplier_framework_lot_jurisdiction_id", null: false
    t.text "position_id", null: false
    t.index ["position_id"], name: "index_supplier_framework_lot_rates_on_position_id"
    t.index ["supplier_framework_lot_id", "position_id", "supplier_framework_lot_jurisdiction_id"], name: "idx_on_supplier_framework_lot_id_position_id_suppli_ed53e87c0a", unique: true
    t.index ["supplier_framework_lot_id"], name: "idx_on_supplier_framework_lot_id_03e2196cfb"
    t.index ["supplier_framework_lot_jurisdiction_id"], name: "idx_on_supplier_framework_lot_jurisdiction_id_e5ffe73c62"
  end

  create_table "supplier_framework_lot_services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_lot_id", null: false
    t.text "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_supplier_framework_lot_services_on_service_id"
    t.index ["supplier_framework_lot_id", "service_id"], name: "idx_on_supplier_framework_lot_id_service_id_1b881a56ab", unique: true
    t.index ["supplier_framework_lot_id"], name: "idx_on_supplier_framework_lot_id_21d10a1b69"
  end

  create_table "supplier_framework_lots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_framework_id", null: false
    t.text "lot_id", null: false
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_supplier_framework_lots_on_lot_id"
    t.index ["supplier_framework_id", "lot_id"], name: "idx_on_supplier_framework_id_lot_id_d9c0566119", unique: true
    t.index ["supplier_framework_id"], name: "index_supplier_framework_lots_on_supplier_framework_id"
  end

  create_table "supplier_frameworks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supplier_id", null: false
    t.text "framework_id", null: false
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["framework_id"], name: "index_supplier_frameworks_on_framework_id"
    t.index ["supplier_id", "framework_id"], name: "index_supplier_frameworks_on_supplier_id_and_framework_id", unique: true
    t.index ["supplier_id"], name: "index_supplier_frameworks_on_supplier_id"
  end

  create_table "suppliers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "duns_number"
    t.boolean "sme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["duns_number"], name: "index_suppliers_on_duns_number", unique: true
    t.index ["name"], name: "index_suppliers_on_name", unique: true
  end

  create_table "supply_teachers_rm6238_admin_current_data", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supply_teachers_rm6238_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.text "fail_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "framework_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["framework_id"], name: "index_uploads_on_framework_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "phone_number", limit: 255
    t.string "mobile_number", limit: 255
    t.datetime "confirmed_at", precision: nil
    t.string "cognito_uuid", limit: 255
    t.integer "roles_mask"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "session_token", limit: 255
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["session_token"], name: "index_users_on_session_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "lots", "frameworks"
  add_foreign_key "positions", "lots"
  add_foreign_key "reports", "frameworks"
  add_foreign_key "reports", "users"
  add_foreign_key "searches", "frameworks"
  add_foreign_key "searches", "users"
  add_foreign_key "services", "lots"
  add_foreign_key "supplier_framework_addresses", "supplier_frameworks"
  add_foreign_key "supplier_framework_contact_details", "supplier_frameworks"
  add_foreign_key "supplier_framework_lot_branches", "supplier_framework_lots"
  add_foreign_key "supplier_framework_lot_jurisdictions", "jurisdictions"
  add_foreign_key "supplier_framework_lot_jurisdictions", "supplier_framework_lots"
  add_foreign_key "supplier_framework_lot_rates", "positions"
  add_foreign_key "supplier_framework_lot_rates", "supplier_framework_lot_jurisdictions"
  add_foreign_key "supplier_framework_lot_rates", "supplier_framework_lots"
  add_foreign_key "supplier_framework_lot_services", "services"
  add_foreign_key "supplier_framework_lot_services", "supplier_framework_lots"
  add_foreign_key "supplier_framework_lots", "lots"
  add_foreign_key "supplier_framework_lots", "supplier_frameworks"
  add_foreign_key "supplier_frameworks", "frameworks"
  add_foreign_key "supplier_frameworks", "suppliers"
  add_foreign_key "uploads", "frameworks"
end
