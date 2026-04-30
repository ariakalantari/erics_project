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

ActiveRecord::Schema[8.1].define(version: 2026_04_29_234126) do
  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "event_type", default: "status_changed", null: false
    t.string "from_status", null: false
    t.integer "parking_spot_id", null: false
    t.string "to_status", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_activities_on_created_at"
    t.index ["parking_spot_id"], name: "index_activities_on_parking_spot_id"
  end

  create_table "chargers", force: :cascade do |t|
    t.integer "connector_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "parking_spot_id", null: false
    t.integer "power_kw", null: false
    t.decimal "price_per_kwh", precision: 6, scale: 2, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["parking_spot_id"], name: "index_chargers_on_parking_spot_id", unique: true
  end

  create_table "parking_areas", force: :cascade do |t|
    t.string "address"
    t.string "city", default: "Stockholm", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "lat", precision: 10, scale: 7, null: false
    t.decimal "lng", precision: 10, scale: 7, null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_parking_areas_on_name", unique: true
  end

  create_table "parking_spots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "identifier", null: false
    t.decimal "lat", precision: 10, scale: 7, null: false
    t.decimal "lng", precision: 10, scale: 7, null: false
    t.integer "parking_area_id", null: false
    t.integer "spot_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_parking_spots_on_identifier", unique: true
    t.index ["parking_area_id"], name: "index_parking_spots_on_parking_area_id"
    t.index ["spot_type"], name: "index_parking_spots_on_spot_type"
    t.index ["status"], name: "index_parking_spots_on_status"
  end

  add_foreign_key "activities", "parking_spots"
  add_foreign_key "chargers", "parking_spots"
  add_foreign_key "parking_spots", "parking_areas"
end
