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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130427022039) do

  create_table "consignment_details", :force => true do |t|
    t.integer  "consignment_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "cost"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "consignment_details", ["consignment_id", "product_id"], :name => "index_consignment_details_on_consignment_id_and_product_id"
  add_index "consignment_details", ["consignment_id"], :name => "index_consignment_details_on_consignment_id"
  add_index "consignment_details", ["product_id"], :name => "index_consignment_details_on_product_id"

  create_table "consignments", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "name"
    t.integer  "status",      :default => 1
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "consignments", ["status"], :name => "index_consignments_on_status"
  add_index "consignments", ["supplier_id"], :name => "index_consignments_on_supplier_id"

  create_table "customers", :force => true do |t|
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "phone"
    t.string   "mobile"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "sku"
    t.string   "short_name"
    t.string   "name"
    t.text     "description"
    t.string   "reference"
    t.date     "last_sale"
    t.date     "last_buy"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_active",   :default => true
  end

  add_index "products", ["short_name"], :name => "index_products_on_short_name", :unique => true
  add_index "products", ["sku"], :name => "index_products_on_sku", :unique => true

  create_table "stocks", :force => true do |t|
    t.integer  "product_id"
    t.decimal  "cost"
    t.decimal  "price"
    t.decimal  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stocks", ["product_id", "cost"], :name => "index_stocks_on_product_id_and_cost"
  add_index "stocks", ["product_id"], :name => "index_stocks_on_product_id"

  create_table "suppliers", :force => true do |t|
    t.string   "short_name"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "suppliers", ["short_name"], :name => "index_suppliers_on_short_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
