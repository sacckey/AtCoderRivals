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

ActiveRecord::Schema.define(version: 2019_10_13_140830) do

  create_table "atcoder_users", force: :cascade do |t|
    t.string "atcoder_id"
    t.integer "accepted_count"
    t.integer "accepted_count_rank"
    t.float "rated_point_sum"
    t.integer "rated_point_sum_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_count"], name: "index_atcoder_users_on_accepted_count"
    t.index ["atcoder_id", "accepted_count"], name: "index_atcoder_users_on_atcoder_id_and_accepted_count"
    t.index ["atcoder_id", "rated_point_sum"], name: "index_atcoder_users_on_atcoder_id_and_rated_point_sum"
    t.index ["atcoder_id"], name: "index_atcoder_users_on_atcoder_id", unique: true
    t.index ["rated_point_sum"], name: "index_atcoder_users_on_rated_point_sum"
  end

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

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "user_name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.integer "atcoder_user_id"
    t.index ["atcoder_user_id"], name: "index_users_on_atcoder_user_id"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
