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

ActiveRecord::Schema.define(version: 20131023164942) do

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
    t.integer  "action"
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

  create_table "advertise_logs", force: true do |t|
    t.integer  "advertisement_id"
    t.integer  "user_id"
    t.integer  "view_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ad_type"
  end

  create_table "advertisement_cpx_logs", force: true do |t|
    t.integer  "ad_id"
    t.integer  "ad_type"
    t.integer  "user_id"
    t.integer  "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisements", force: true do |t|
    t.integer  "kind"
    t.integer  "count"
    t.integer  "remain"
    t.string   "local"
    t.integer  "interest"
    t.integer  "sexual"
    t.integer  "facebook"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ads_num"
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
    t.string   "android_package"
    t.string   "ios_package"
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

  create_table "cpd_ads", force: true do |t|
    t.integer  "cpd_kind"
    t.string   "front_image"
    t.string   "back_image"
    t.integer  "coupon_id"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cpd_advertisements", force: true do |t|
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
    t.string   "ad_name"
  end

  create_table "cpdm_advertisements", force: true do |t|
    t.integer  "ad_type"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "count"
    t.integer  "remain"
    t.integer  "priority"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ad_name"
    t.integer  "length"
  end

  create_table "cpx_advertisements", force: true do |t|
    t.integer  "ad_type"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "count"
    t.integer  "remain"
    t.integer  "priority",     default: 5
    t.string   "ad_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ad_text"
    t.string   "store_url"
    t.string   "confirm_url"
    t.string   "package_name"
    t.string   "ad_image"
    t.integer  "reward"
    t.integer  "n_question"
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

  create_table "user_records", force: true do |t|
    t.integer  "record_type"
    t.integer  "level"
    t.integer  "stage"
    t.integer  "record_point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_stages", force: true do |t|
    t.integer  "user_id"
    t.integer  "category"
    t.integer  "stage"
    t.integer  "level"
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
    t.integer  "level_test"
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
