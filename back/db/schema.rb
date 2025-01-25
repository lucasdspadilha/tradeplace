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

ActiveRecord::Schema[7.2].define(version: 2025_01_24_122753) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "cep"
    t.string "complement"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.decimal "rating_value", precision: 3, scale: 2, default: "0.0", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_feedbacks_on_product_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.text "product_img", null: false
    t.string "product_name", limit: 255, null: false
    t.decimal "rating_value", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "product_value", precision: 10, scale: 2, null: false
    t.integer "qty_available", null: false
    t.integer "qty_sold", null: false
    t.string "product_description"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone"
    t.integer "address_id"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "feedbacks", "products"
  add_foreign_key "feedbacks", "users"
end
