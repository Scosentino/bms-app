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

ActiveRecord::Schema.define(version: 20180523132411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "legal_name"
    t.string "dba"
    t.text "address_line_1"
    t.text "address_line_2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "federal_tax_id"
    t.text "name_of_credit_card_processor"
    t.integer "years_processor"
    t.string "merchant_id_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_businesses_on_customer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "admin_id"
    t.bigint "order_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "estimated_annual_savings"
    t.datetime "accepted_at"
    t.string "customer_name"
    t.index ["admin_id"], name: "index_offers_on_admin_id"
    t.index ["customer_id"], name: "index_offers_on_customer_id"
    t.index ["order_id"], name: "index_offers_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id"
    t.json "documents"
    t.boolean "accepted_policy", default: false
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reviewed", default: false
    t.integer "status", default: 0
    t.bigint "business_id"
    t.datetime "accepted_at"
    t.string "customer_name"
    t.index ["business_id"], name: "index_orders_on_business_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.bigint "customer_id"
    t.integer "payment_type", default: 0
    t.string "card_number"
    t.integer "security_code"
    t.string "zipcode"
    t.string "bank_account_number"
    t.string "bank_account_routing_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "year_ended"
    t.string "month_ended"
    t.string "bank_name"
    t.index ["customer_id"], name: "index_payment_methods_on_customer_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.json "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "user_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.integer "ssn"
    t.string "job_title"
    t.boolean "completed", default: false
    t.json "navbar_logo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "offers", "orders"
end
