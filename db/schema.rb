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

ActiveRecord::Schema.define(version: 20140923203426) do

  create_table "companies", force: true do |t|
    t.string "name"
  end

  create_table "positions", force: true do |t|
    t.string "name"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "score_id"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["score_id"], name: "index_products_on_score_id", using: :btree

  create_table "sales", force: true do |t|
    t.integer  "score_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["score_id"], name: "index_sales_on_score_id", using: :btree
  add_index "sales", ["user_id"], name: "index_sales_on_user_id", using: :btree

  create_table "scores", force: true do |t|
    t.string   "code"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subsidiaries", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "subsidiaries", ["company_id"], name: "index_subsidiaries_on_company_id", using: :btree

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "dni"
    t.string  "employee_file_number"
    t.integer "subsidiary_id"
    t.integer "company_id"
    t.integer "position_id"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["position_id"], name: "index_users_on_position_id", using: :btree
  add_index "users", ["subsidiary_id"], name: "index_users_on_subsidiary_id", using: :btree

end
