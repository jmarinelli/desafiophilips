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

ActiveRecord::Schema.define(version: 20141008170850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answered_questions", force: true do |t|
    t.integer "user_id"
    t.integer "question_id"
  end

  add_index "answered_questions", ["question_id"], name: "index_answered_questions_on_question_id", using: :btree
  add_index "answered_questions", ["user_id"], name: "index_answered_questions_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.integer "points"
  end

  create_table "companies", force: true do |t|
    t.string "name"
  end

  create_table "options", force: true do |t|
    t.string  "text"
    t.integer "question_id"
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "positions", force: true do |t|
    t.string "name"
  end

  create_table "products", force: true do |t|
    t.string  "name"
    t.integer "company_id"
    t.integer "score"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree

  create_table "questions", force: true do |t|
    t.string  "text"
    t.integer "correct_option_id"
    t.integer "points"
  end

  create_table "sales", force: true do |t|
    t.integer "product_id"
    t.integer "amount"
    t.string  "user_employee_file_number"
  end

  add_index "sales", ["product_id"], name: "index_sales_on_product_id", using: :btree

  create_table "scores", force: true do |t|
    t.string   "code"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subsidiaries", force: true do |t|
    t.string  "name"
    t.integer "company_id"
    t.string  "cluster"
  end

  add_index "subsidiaries", ["company_id"], name: "index_subsidiaries_on_company_id", using: :btree

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "dni"
    t.string  "employee_file_number"
    t.integer "subsidiary_id"
    t.integer "company_id"
    t.integer "position_id"
    t.integer "trivia_points"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["position_id"], name: "index_users_on_position_id", using: :btree
  add_index "users", ["subsidiary_id"], name: "index_users_on_subsidiary_id", using: :btree

end
