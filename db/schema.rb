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

ActiveRecord::Schema[7.1].define(version: 2024_07_04_000322) do
  create_table "breed_details", force: :cascade do |t|
    t.string "temperament"
    t.string "life_span"
    t.string "weight"
    t.string "height"
    t.string "image_url"
    t.integer "breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breed_id"], name: "index_breed_details_on_breed_id"
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "breeds_owners", id: false, force: :cascade do |t|
    t.integer "breed_id", null: false
    t.integer "owner_id", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.integer "breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breed_id"], name: "index_images_on_breed_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_breeds", force: :cascade do |t|
    t.string "name"
    t.integer "breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["breed_id"], name: "index_sub_breeds_on_breed_id"
  end

  add_foreign_key "breed_details", "breeds"
  add_foreign_key "images", "breeds"
  add_foreign_key "sub_breeds", "breeds"
end
