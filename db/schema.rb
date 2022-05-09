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

ActiveRecord::Schema[7.0].define(version: 2022_05_08_035825) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "game_details", force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "game_id"
    t.integer "turn", null: false
    t.integer "hand_id"
    t.integer "support_id"
    t.integer "round_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_details_on_game_id"
    t.index ["user_id"], name: "index_game_details_on_user_id"
  end

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "field_id", default: 1, null: false
    t.string "winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_hands", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "hand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hand_id"], name: "index_user_hands_on_hand_id"
    t.index ["user_id"], name: "index_user_hands_on_user_id"
  end

  create_table "user_supports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "support_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["support_id"], name: "index_user_supports_on_support_id"
    t.index ["user_id"], name: "index_user_supports_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "user_token_digest"
    t.integer "role", null: false
    t.string "game_id", null: false
    t.integer "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "role"], name: "index_users_on_game_id_and_role", unique: true
  end

  add_foreign_key "game_details", "games"
  add_foreign_key "game_details", "users"
  add_foreign_key "user_hands", "users"
  add_foreign_key "user_supports", "users"
end
