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

ActiveRecord::Schema.define(version: 2020_06_13_125241) do

  create_table "clubs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "white_id"
    t.integer "black_id"
    t.string "event", null: false
    t.string "round"
    t.integer "handicap", default: 0
    t.decimal "komi", precision: 2, scale: 1, null: false
    t.string "result"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["black_id"], name: "index_matches_on_black_id"
    t.index ["white_id"], name: "index_matches_on_white_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.integer "club_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_id"], name: "index_players_on_club_id"
  end

  add_foreign_key "matches", "players", column: "black_id"
  add_foreign_key "matches", "players", column: "white_id"
  add_foreign_key "players", "clubs"
end
