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

ActiveRecord::Schema[7.0].define(version: 2023_08_22_083445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colleagues", force: :cascade do |t|
    t.string "name", null: false
    t.string "position"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.string "date", default: ""
    t.string "links", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publication_periods", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string "title", null: false
    t.string "source", null: false
    t.string "source_url", null: false
    t.string "authors", default: [], array: true
    t.bigint "publication_period_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_period_id"], name: "index_publications_on_publication_period_id"
  end

  add_foreign_key "publications", "publication_periods"
end
