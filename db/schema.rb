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

ActiveRecord::Schema.define(version: 20180411185924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "columns", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "databases", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "database_identifier"
    t.index ["database_identifier"], name: "index_databases_on_database_identifier", unique: true
    t.index ["project_id"], name: "index_databases_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "db_username"
    t.string "db_password"
  end

  create_table "row_values", force: :cascade do |t|
    t.bigint "row_id"
    t.bigint "column_id"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_row_values_on_column_id"
    t.index ["row_id"], name: "index_row_values_on_row_id"
  end

  create_table "rows", force: :cascade do |t|
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_rows_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.bigint "database_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["database_id"], name: "index_tables_on_database_id"
  end

  add_foreign_key "columns", "tables"
  add_foreign_key "databases", "projects"
  add_foreign_key "row_values", "columns"
  add_foreign_key "row_values", "rows"
  add_foreign_key "rows", "tables"
  add_foreign_key "tables", "databases"
end
