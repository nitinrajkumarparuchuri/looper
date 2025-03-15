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

ActiveRecord::Schema[8.0].define(version: 2025_03_15_174148) do
  create_table "cards", force: :cascade do |t|
    t.string "content"
    t.string "card_type"
    t.integer "game_id", null: false
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_cards_on_game_id"
    t.index ["player_id"], name: "index_cards_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "status"
    t.integer "current_turn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_turn_player_id"
    t.boolean "game_won"
    t.boolean "sara_trusts_young_joe"
    t.integer "primary_rainmaker_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "x"
    t.integer "y"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_rainmaker"
    t.boolean "primary_rainmaker"
    t.index ["game_id"], name: "index_locations_on_game_id"
  end

  create_table "player_positions", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_player_positions_on_location_id"
    t.index ["player_id"], name: "index_player_positions_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.integer "game_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "rainmaker_kills", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_rainmaker_kills_on_location_id"
    t.index ["player_id"], name: "index_rainmaker_kills_on_player_id"
  end

  add_foreign_key "cards", "games"
  add_foreign_key "cards", "players"
  add_foreign_key "locations", "games"
  add_foreign_key "player_positions", "locations"
  add_foreign_key "player_positions", "players"
  add_foreign_key "players", "games"
  add_foreign_key "rainmaker_kills", "locations"
  add_foreign_key "rainmaker_kills", "players"
end
