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

ActiveRecord::Schema[8.0].define(version: 2025_06_17_075028) do
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

  create_table "frameworks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "service", limit: 25
    t.string "framework", limit: 6
    t.date "live_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_at"
  end

  create_table "legal_services_rm6240_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.text "import_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legal_services_rm6240_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "legal_services_rm6240_supplier_id"
    t.string "lot_number", limit: 1, null: false
    t.string "jurisdiction", limit: 1
    t.string "position", limit: 1, null: false
    t.integer "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["legal_services_rm6240_supplier_id", "lot_number", "jurisdiction", "position"], name: "index_rates_on_supplier_id_lot_number_position_jurisdiction", unique: true
    t.index ["legal_services_rm6240_supplier_id"], name: "index_ls_rm6240_rates_on_ls_rm6240_supplier_id"
  end

  create_table "legal_services_rm6240_service_offerings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "legal_services_rm6240_supplier_id"
    t.string "service_code", limit: 4, null: false
    t.string "jurisdiction", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["legal_services_rm6240_supplier_id", "service_code", "jurisdiction"], name: "index_rates_on_supplier_id_and_service_code_and_jurisdiction", unique: true
    t.index ["legal_services_rm6240_supplier_id"], name: "index_ls_rm6240_service_offerings_on_ls_rm6240_supplier_id"
  end

  create_table "legal_services_rm6240_suppliers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "email"
    t.text "phone_number"
    t.text "website"
    t.text "address"
    t.boolean "sme"
    t.integer "duns"
    t.text "lot_1_prospectus_link"
    t.text "lot_2_prospectus_link"
    t.text "lot_3_prospectus_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legal_services_rm6240_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "management_consultancy_rm6187_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "import_errors"
  end

  create_table "management_consultancy_rm6187_rate_cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "management_consultancy_rm6187_supplier_id", null: false
    t.string "lot"
    t.integer "junior_rate_in_pence"
    t.integer "standard_rate_in_pence"
    t.integer "senior_rate_in_pence"
    t.integer "principal_rate_in_pence"
    t.integer "managing_rate_in_pence"
    t.integer "director_rate_in_pence"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "contact_name"
    t.string "telephone_number"
    t.string "email"
    t.index ["management_consultancy_rm6187_supplier_id"], name: "index_mc_rm6187_rate_cards_on_supplier_id"
  end

  create_table "management_consultancy_rm6187_service_offerings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "management_consultancy_rm6187_supplier_id", null: false
    t.text "lot_number", null: false
    t.text "service_code", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["management_consultancy_rm6187_supplier_id"], name: "index_mc_rm6187_service_offerings_on_mc_supplier_id"
    t.index ["service_code", "lot_number", "management_consultancy_rm6187_supplier_id"], name: "index_rm6187_service_on_lot_number_and_mc_supplier_id", unique: true
  end

  create_table "management_consultancy_rm6187_suppliers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "contact_name"
    t.text "contact_email"
    t.text "telephone_number"
    t.boolean "sme"
    t.string "address"
    t.string "website"
    t.integer "duns"
  end

  create_table "management_consultancy_rm6187_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "management_consultancy_rm6309_admin_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "aasm_state", limit: 30
    t.text "import_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "management_consultancy_rm6309_rate_cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "management_consultancy_rm6309_supplier_id"
    t.text "lot"
    t.text "rate_type"
    t.integer "junior_rate_in_pence"
    t.integer "standard_rate_in_pence"
    t.integer "senior_rate_in_pence"
    t.integer "principal_rate_in_pence"
    t.integer "managing_rate_in_pence"
    t.integer "director_rate_in_pence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot", "rate_type", "management_consultancy_rm6309_supplier_id"], name: "index_rm6309_lot_on_type_and_mc_supplier_id", unique: true
    t.index ["management_consultancy_rm6309_supplier_id"], name: "index_mc_rm6309_rate_cards_on_supplier_id"
  end

  create_table "management_consultancy_rm6309_service_offerings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "management_consultancy_rm6309_supplier_id"
    t.text "lot_number", null: false
    t.text "service_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["management_consultancy_rm6309_supplier_id"], name: "index_mc_rm6309_service_offerings_on_mc_supplier_id"
    t.index ["service_code", "lot_number", "management_consultancy_rm6309_supplier_id"], name: "index_rm6309_service_on_lot_number_and_mc_supplier_id", unique: true
  end

  create_table "management_consultancy_rm6309_suppliers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "contact_name"
    t.text "contact_email"
    t.text "telephone_number"
    t.boolean "sme"
    t.text "address"
    t.text "website"
    t.integer "duns"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "management_consultancy_rm6309_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nuts_regions", id: false, force: :cascade do |t|
    t.string "code", limit: 255
    t.string "name", limit: 255
    t.string "nuts1_code", limit: 255
    t.string "nuts2_code", limit: 255
    t.index ["code"], name: "nuts_regions_code_key", unique: true
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

  create_table "supply_teachers_rm6238_branches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supply_teachers_rm6238_supplier_id"
    t.text "slug"
    t.geography "location", limit: {srid: 4326, type: "st_point", geographic: true}
    t.string "postcode", limit: 8, null: false
    t.text "contact_name"
    t.text "contact_email"
    t.text "telephone_number"
    t.text "name"
    t.text "town"
    t.text "address_1"
    t.text "address_2"
    t.text "county"
    t.text "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_supply_teachers_rm6238_branches_on_slug"
    t.index ["supply_teachers_rm6238_supplier_id"], name: "index_st_rm6238_branches_on_st_rm6238_supplier_id"
  end

  create_table "supply_teachers_rm6238_managed_service_providers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supply_teachers_rm6238_supplier_id"
    t.string "lot_number", limit: 4, null: false
    t.text "contact_name"
    t.text "telephone_number"
    t.text "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_number"], name: "index_st_rm6238_managed_service_providers_on_lot_number"
    t.index ["supply_teachers_rm6238_supplier_id"], name: "index_st_rm6238_service_providers_on_st_rm6238_supplier_id"
  end

  create_table "supply_teachers_rm6238_rates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "supply_teachers_rm6238_supplier_id"
    t.string "lot_number", limit: 4, null: false
    t.integer "rate", null: false
    t.text "job_type", null: false
    t.text "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supply_teachers_rm6238_supplier_id", "lot_number", "job_type", "term"], name: "index_rates_on_supplier_id_and_lot_number_and_job_and_tenure", unique: true
    t.index ["supply_teachers_rm6238_supplier_id"], name: "index_st_rm6238_rates_on_st_rm6238_supplier_id"
  end

  create_table "supply_teachers_rm6238_suppliers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supply_teachers_rm6238_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  add_foreign_key "legal_services_rm6240_rates", "legal_services_rm6240_suppliers"
  add_foreign_key "legal_services_rm6240_service_offerings", "legal_services_rm6240_suppliers"
  add_foreign_key "management_consultancy_rm6187_rate_cards", "management_consultancy_rm6187_suppliers"
  add_foreign_key "management_consultancy_rm6187_service_offerings", "management_consultancy_rm6187_suppliers"
  add_foreign_key "management_consultancy_rm6309_rate_cards", "management_consultancy_rm6309_suppliers"
  add_foreign_key "management_consultancy_rm6309_service_offerings", "management_consultancy_rm6309_suppliers"
  add_foreign_key "supply_teachers_rm6238_branches", "supply_teachers_rm6238_suppliers"
  add_foreign_key "supply_teachers_rm6238_managed_service_providers", "supply_teachers_rm6238_suppliers"
  add_foreign_key "supply_teachers_rm6238_rates", "supply_teachers_rm6238_suppliers"
end
