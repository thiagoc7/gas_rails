# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150623192635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measures", force: :cascade do |t|
    t.integer  "plan_id"
    t.integer  "tank_id"
    t.integer  "buy_volume",      default: 0
    t.integer  "forecast_volume", default: 0
    t.integer  "final_volume"
    t.string   "comments"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "measures", ["plan_id"], name: "index_measures_on_plan_id", using: :btree
  add_index "measures", ["tank_id"], name: "index_measures_on_tank_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.date     "date",                              null: false
    t.integer  "day_of_week"
    t.integer  "date_type"
    t.boolean  "finished",          default: false
    t.string   "holiday"
    t.integer  "holiday_reference"
    t.integer  "station_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "plans", ["station_id"], name: "index_plans_on_station_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.string   "gasoline"
    t.string   "amount"
    t.integer  "supplier_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "prices", ["supplier_id"], name: "index_prices_on_supplier_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.string   "strong_days"
    t.string   "weak_days"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tanks", force: :cascade do |t|
    t.string   "gasoline"
    t.integer  "capacity"
    t.integer  "min_volume"
    t.integer  "max_volume"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "number"
  end

  add_index "tanks", ["station_id"], name: "index_tanks_on_station_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "measures", "plans"
  add_foreign_key "measures", "tanks"
  add_foreign_key "plans", "stations"
  add_foreign_key "prices", "suppliers"
  add_foreign_key "tanks", "stations"
end
