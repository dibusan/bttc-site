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

ActiveRecord::Schema.define(version: 20200601025817) do

  create_table "day_blocks", force: :cascade do |t|
    t.datetime "schedule_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "coach_id"
    t.index ["coach_id"], name: "index_day_blocks_on_coach_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "coach_id"
    t.integer  "user_id"
    t.integer  "club_table"
    t.integer  "party_size",    default: 1
    t.boolean  "type_play?",    default: true
    t.boolean  "type_lesson?"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "scheduled_for"
    t.index ["coach_id"], name: "index_reservations_on_coach_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "time_blocks", force: :cascade do |t|
    t.datetime "block_start_time"
    t.integer  "availability"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "day_block_id"
    t.index ["day_block_id"], name: "index_time_blocks_on_day_block_id"
  end

  create_table "time_blocks_users", id: false, force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "time_block_id", null: false
    t.index ["time_block_id", "user_id"], name: "index_time_blocks_users_on_time_block_id_and_user_id"
    t.index ["user_id", "time_block_id"], name: "index_time_blocks_users_on_user_id_and_time_block_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin_role",             default: false
    t.boolean  "user_role",              default: true
    t.boolean  "coach_role",             default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
