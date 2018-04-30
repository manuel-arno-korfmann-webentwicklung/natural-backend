# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180430103024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "columns", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["table_id"], name: "index_columns_on_table_id"
    t.index ["user_id"], name: "index_columns_on_user_id"
  end

  create_table "databases", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "database_identifier"
    t.bigint "user_id"
    t.index ["database_identifier"], name: "index_databases_on_database_identifier", unique: true
    t.index ["project_id"], name: "index_databases_on_project_id"
    t.index ["user_id"], name: "index_databases_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "db_username"
    t.string "db_password"
    t.string "password_digest"
    t.boolean "locked"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "queries", force: :cascade do |t|
    t.text "request_data"
    t.text "response_data"
    t.bigint "database_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["database_id"], name: "index_queries_on_database_id"
  end

  create_table "row_values", force: :cascade do |t|
    t.bigint "row_id"
    t.bigint "column_id"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["column_id"], name: "index_row_values_on_column_id"
    t.index ["row_id"], name: "index_row_values_on_row_id"
    t.index ["user_id"], name: "index_row_values_on_user_id"
  end

  create_table "rows", force: :cascade do |t|
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "db_id"
    t.bigint "user_id"
    t.index ["table_id"], name: "index_rows_on_table_id"
    t.index ["user_id"], name: "index_rows_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.bigint "database_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["database_id"], name: "index_tables_on_database_id"
    t.index ["user_id"], name: "index_tables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "columns", "tables"
  add_foreign_key "columns", "users"
  add_foreign_key "databases", "projects"
  add_foreign_key "databases", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "row_values", "columns"
  add_foreign_key "row_values", "rows"
  add_foreign_key "row_values", "users"
  add_foreign_key "rows", "tables"
  add_foreign_key "rows", "users"
  add_foreign_key "tables", "databases"
  add_foreign_key "tables", "users"
end
