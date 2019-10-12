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

ActiveRecord::Schema.define(version: 2019_10_12_071228) do

  create_table "contests", force: :cascade do |t|
    t.string "abbreviation"
    t.integer "start_epoch_second"
    t.integer "duration_second"
    t.string "title"
    t.string "rate_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["start_epoch_second"], name: "index_contests_on_start_epoch_second"
  end

  create_table "histories", force: :cascade do |t|
    t.string "atcoder_id"
    t.boolean "is_rated"
    t.integer "place"
    t.integer "old_rating"
    t.integer "new_rating"
    t.integer "performance"
    t.integer "inner_performance"
    t.string "contest_screen_name"
    t.string "contest_name"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atcoder_id", "contest_name"], name: "index_histories_on_atcoder_id_and_contest_name", unique: true
    t.index ["atcoder_id"], name: "index_histories_on_atcoder_id"
    t.index ["contest_name"], name: "index_histories_on_contest_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "user_name"
    t.string "image_url"
    t.string "atcoder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
