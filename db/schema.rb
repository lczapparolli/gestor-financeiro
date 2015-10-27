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

ActiveRecord::Schema.define(version: 20151008024734) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forecasts", force: :cascade do |t|
    t.integer  "period_id"
    t.integer  "budget_id"
    t.decimal  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "forecasts", ["budget_id"], name: "index_forecasts_on_budget_id"
  add_index "forecasts", ["period_id"], name: "index_forecasts_on_period_id"

  create_table "movements", force: :cascade do |t|
    t.string   "description"
    t.date     "date"
    t.decimal  "amount"
    t.integer  "account_id"
    t.integer  "budget_id"
    t.integer  "period_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "movements", ["account_id"], name: "index_movements_on_account_id"
  add_index "movements", ["budget_id"], name: "index_movements_on_budget_id"
  add_index "movements", ["period_id"], name: "index_movements_on_period_id"

  create_table "periods", force: :cascade do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
