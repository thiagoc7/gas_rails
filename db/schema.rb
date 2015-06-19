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

ActiveRecord::Schema.define(version: 20150618021233) do

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

  add_index "measures", ["plan_id"], name: "index_measures_on_plan_id"
  add_index "measures", ["tank_id"], name: "index_measures_on_tank_id"

  create_table "plans", force: :cascade do |t|
    t.date     "date",                        null: false
    t.string   "holiday"
    t.boolean  "day_before",  default: false
    t.string   "day_of_week"
    t.integer  "station_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "plans", ["station_id"], name: "index_plans_on_station_id"

  create_table "stations", force: :cascade do |t|
    t.string   "name"
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
  end

  add_index "tanks", ["station_id"], name: "index_tanks_on_station_id"

end
