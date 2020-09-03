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

ActiveRecord::Schema.define(version: 2020_09_03_155702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_tables", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "phone_number"
    t.string "description"
  end

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "phone_number"
    t.string "description"
  end

  create_table "applications_pets", force: :cascade do |t|
    t.bigint "applications_id"
    t.bigint "pets_id"
    t.index ["applications_id"], name: "index_applications_pets_on_applications_id"
    t.index ["pets_id"], name: "index_applications_pets_on_pets_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.integer "approximate_age"
    t.string "sex"
    t.string "current_location"
    t.string "adoption_status"
    t.bigint "shelter_id"
    t.boolean "favorite"
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.integer "rating"
    t.string "content"
    t.string "image"
    t.bigint "shelter_id"
    t.index ["shelter_id"], name: "index_reviews_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  add_foreign_key "applications_pets", "applications", column: "applications_id"
  add_foreign_key "applications_pets", "pets", column: "pets_id"
  add_foreign_key "pets", "shelters"
  add_foreign_key "reviews", "shelters"
end
