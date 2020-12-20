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

ActiveRecord::Schema.define(version: 2020_12_19_212856) do

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.boolean "in_stock"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "noodles", force: :cascade do |t|
    t.string "flavor"
    t.string "description"
    t.integer "brand_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_noodles_on_brand_id"
    t.index ["user_id"], name: "index_noodles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "stars"
    t.string "title"
    t.string "content"
    t.integer "user_id", null: false
    t.integer "noodle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["noodle_id"], name: "index_reviews_on_noodle_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "noodles", "brands"
  add_foreign_key "noodles", "users"
  add_foreign_key "reviews", "noodles"
  add_foreign_key "reviews", "users"
end
