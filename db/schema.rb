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

ActiveRecord::Schema.define(version: 2019_12_11_153925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.float "distance"
    t.string "origin"
    t.string "destination"
    t.bigint "vessel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vessel_id"], name: "index_routes_on_vessel_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "route_id"
    t.bigint "vessel_id"
    t.string "days"
    t.time "start_time"
    t.time "end_time"
    t.text "remarks"
    t.string "type"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_schedules_on_route_id"
    t.index ["vessel_id"], name: "index_schedules_on_vessel_id"
  end

  create_table "vessels", force: :cascade do |t|
    t.string "name"
    t.boolean "decommissioned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "routes", "vessels"
  add_foreign_key "schedules", "routes"
  add_foreign_key "schedules", "vessels"
end
