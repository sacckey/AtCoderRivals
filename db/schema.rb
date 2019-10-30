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

ActiveRecord::Schema.define(version: 2019_10_27_093129) do

  create_table "atcoder_users", force: :cascade do |t|
    t.string "atcoder_id"
    t.integer "accepted_count"
    t.integer "accepted_count_rank"
    t.float "rated_point_sum"
    t.integer "rated_point_sum_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "rating"
    t.index ["accepted_count"], name: "index_atcoder_users_on_accepted_count"
    t.index ["atcoder_id", "accepted_count"], name: "index_atcoder_users_on_atcoder_id_and_accepted_count"
    t.index ["atcoder_id", "rated_point_sum"], name: "index_atcoder_users_on_atcoder_id_and_rated_point_sum"
    t.index ["atcoder_id"], name: "index_atcoder_users_on_atcoder_id", unique: true
    t.index ["rated_point_sum"], name: "index_atcoder_users_on_rated_point_sum"
  end

  create_table "contests", force: :cascade do |t|
    t.string "name"
    t.integer "start_epoch_second"
    t.integer "duration_second"
    t.string "title"
    t.string "rate_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "start_epoch_second"], name: "index_contests_on_name_and_start_epoch_second", unique: true
    t.index ["name"], name: "index_contests_on_name", unique: true
    t.index ["start_epoch_second"], name: "index_contests_on_start_epoch_second"
    t.index ["title", "start_epoch_second"], name: "index_contests_on_title_and_start_epoch_second", unique: true
  end

  create_table "histories", force: :cascade do |t|
    t.boolean "is_rated"
    t.integer "place"
    t.integer "old_rating"
    t.integer "new_rating"
    t.integer "performance"
    t.integer "inner_performance"
    t.string "contest_screen_name"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "atcoder_user_id"
    t.string "contest_name"
    t.index ["atcoder_user_id"], name: "index_histories_on_atcoder_user_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contest_name"
    t.index ["name"], name: "index_problems_on_contest_id_and_name"
    t.index ["name"], name: "index_problems_on_name", unique: true
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

  create_table "submissions", force: :cascade do |t|
    t.integer "epoch_second"
    t.integer "atcoder_user_id"
    t.string "language"
    t.float "point"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contest_name"
    t.string "problem_name"
    t.integer "number"
    t.index ["atcoder_user_id", "epoch_second"], name: "index_submissions_on_atcoder_user_id_and_epoch_second"
    t.index ["atcoder_user_id"], name: "index_submissions_on_atcoder_user_id"
    t.index ["epoch_second"], name: "index_submissions_on_epoch_second"
    t.index ["number"], name: "index_submissions_on_number", unique: true
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
