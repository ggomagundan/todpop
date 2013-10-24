# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131024205738) do

  create_table "addresses", force: true do |t|
    t.string   "depth1"
    t.string   "depth2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertise_cpd_logs", force: true do |t|
    t.integer  "ad_id"
    t.integer  "ad_type"
    t.integer  "user_id"
    t.integer  "act"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertise_cpdm_logs", force: true do |t|
    t.integer  "ad_id"
    t.integer  "ad_type",    default: 201
    t.integer  "user_id"
    t.integer  "view_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertise_cpx_logs", force: true do |t|
    t.integer  "ad_id"
    t.integer  "ad_type"
    t.integer  "user_id"
    t.integer  "act"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_infos", force: true do |t|
    t.string   "time"
    t.string   "one_star"
    t.string   "two_star"
    t.string   "max_money"
    t.string   "android_version"
    t.string   "ios_version"
    t.string   "app_server"
    t.integer  "popup_style"
    t.string   "popup_image"
    t.text     "popup_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_limit"
    t.string   "android_package_name"
    t.string   "ios_package_name"
    t.string   "market_url"
    t.string   "appstore_url"
  end

  create_table "app_introduce_videos", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "user"
    t.datetime "attendance_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cacao_ments", force: true do |t|
    t.string   "ment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cpd_advertisements", force: true do |t|
    t.string   "ad_name"
    t.integer  "ad_type"
    t.integer  "count"
    t.integer  "remain"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "front_image"
    t.string   "back_image"
    t.integer  "coupon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",    default: 4
  end

  create_table "cpdm_advertisements", force: true do |t|
    t.string   "ad_name"
    t.integer  "ad_type",    default: 201
    t.integer  "count"
    t.integer  "remain"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "url"
    t.string   "length"
    t.integer  "priority",   default: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video"
  end

  create_table "cpx_advertisements", force: true do |t|
    t.string   "ad_name"
    t.integer  "ad_type"
    t.integer  "count"
    t.integer  "remain"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "ad_image"
    t.string   "ad_text"
    t.string   "store_url"
    t.string   "package_name"
    t.string   "confirm_url"
    t.integer  "reward"
    t.integer  "n_question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",     default: 5
  end

  create_table "exam_infos", force: true do |t|
    t.integer  "time"
    t.integer  "one_star"
    t.integer  "two_star"
    t.integer  "max_money"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "helps", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "level",      null: false
    t.integer  "stage",      null: false
    t.integer  "index",      null: false
    t.integer  "word_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_coupons", force: true do |t|
    t.integer  "user_id"
    t.integer  "coupon_type"
    t.integer  "coupon_id"
    t.integer  "availability", default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", force: true do |t|
    t.string   "name"
    t.integer  "point_type"
    t.integer  "point"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "content"
    t.integer  "rank"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
    t.integer  "period"
  end

  create_table "refund_infos", force: true do |t|
    t.string   "name"
    t.string   "bank"
    t.string   "account"
    t.integer  "sum"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "reward_sums", force: true do |t|
    t.integer  "current"
    t.integer  "0"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content",    default: "THIS IS NOTICE"
  end

  create_table "rewards", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "sub_title"
    t.integer  "reward_point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reward_type"
  end

  create_table "survey_contents", force: true do |t|
    t.integer  "ad_id"
    t.integer  "q_no"
    t.integer  "q_type"
    t.string   "q_text"
    t.string   "q_image"
    t.integer  "n_answer"
    t.string   "a1"
    t.string   "a2"
    t.string   "a3"
    t.string   "a4"
    t.string   "a5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_record_bests", force: true do |t|
    t.integer  "user_id"
    t.integer  "level"
    t.integer  "stage"
    t.integer  "n_medals_best"
    t.integer  "score_best"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_stages", force: true do |t|
    t.integer  "user_id"
    t.integer  "category"
    t.integer  "stage"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_test_histories", force: true do |t|
    t.integer  "user_id"
    t.integer  "category"
    t.integer  "level"
    t.integer  "stage"
    t.integer  "n_medals"
    t.integer  "score"
    t.integer  "reward"
    t.integer  "rank_point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "facebook"
    t.string   "password_digest",                      null: false
    t.string   "nickname",                             null: false
    t.string   "recommend"
    t.integer  "sex"
    t.date     "birth"
    t.string   "address"
    t.string   "mobile",                               null: false
    t.datetime "date"
    t.datetime "last_connection"
    t.integer  "level_test",               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "point",                    default: 0
    t.integer  "attendance_time",          default: 0
    t.integer  "interest"
    t.integer  "is_admin",                 default: 0
    t.integer  "is_set_facebook_password", default: 0
  end

  create_table "words", force: true do |t|
    t.string   "name",                   null: false
    t.string   "mean",                   null: false
    t.text     "example_en"
    t.text     "example_ko"
    t.string   "phonetics"
    t.integer  "picture",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "confirm",    default: 0
  end

end
