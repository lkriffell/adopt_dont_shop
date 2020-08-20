class CreateStructure < ActiveRecord::Migration[5.2]
  def change
    enable_extension "plpgsql"

    create_table "pets", force: :cascade do |t|
      t.string "image"
      t.string "name"
      t.integer "approximate_age"
      t.string "sex"
      t.string "current_location"
      t.string "adoption_status"
      t.bigint "shelter_id"
      t.index ["shelter_id"], name: "index_pets_on_shelter_id"
    end

    create_table "shelters", force: :cascade do |t|
      t.string "name"
      t.string "address"
      t.string "city"
      t.string "state"
      t.integer "zip"
    end

    add_foreign_key "pets", "shelters"
  end
end
