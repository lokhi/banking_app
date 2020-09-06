# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_05_150008) do

  create_table "cards", force: :cascade do |t|
    t.integer "wallet_id"
    t.string "currency"
    t.decimal "current_balance", precision: 12, scale: 2, default: "0.0"
    t.string "numbers"
    t.date "expiration_date"
    t.string "ccv"
    t.integer "user_id"
    t.integer "status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "amount"
    t.string "origin_currency"
    t.string "target_currency"
    t.decimal "conversion_fee", precision: 12, scale: 2, default: "0.0"
    t.string "origin_transfer_type"
    t.integer "origin_transfer_id"
    t.string "target_transfer_type"
    t.integer "target_transfer_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin_transfer_type", "origin_transfer_id"], name: "index_transfers_on_origin_transfer_type_and_origin_transfer_id"
    t.index ["target_transfer_type", "target_transfer_id"], name: "index_transfers_on_target_transfer_type_and_target_transfer_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "current_balance", precision: 12, scale: 2, default: "0.0"
    t.string "currency"
    t.integer "company_id"
    t.boolean "master", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
