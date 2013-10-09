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

ActiveRecord::Schema.define(version: 20131009170946) do

  create_table "addresses", force: true do |t|
    t.string   "depth1"
    t.string   "depth2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertise_logs", force: true do |t|
    t.integer  "advertisement_id"
    t.integer  "user_id"
    t.integer  "view_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisements", force: true do |t|
    t.integer  "kind"
    t.string   "content1"
    t.string   "content2"
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

  create_table "exam_infos", force: true do |t|
    t.integer  "time"
    t.integer  "one_star"
    t.integer  "two_star"
    t.integer  "max_money"
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

  create_table "user_records", force: true do |t|
    t.integer  "record_type"
    t.integer  "level"
    t.integer  "stage"
    t.integer  "record_point"
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

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "facebook"
    t.string   "password_digest",             null: false
    t.string   "nickname",                    null: false
    t.string   "recommend"
    t.integer  "sex"
    t.date     "birth"
    t.string   "address"
    t.string   "mobile",                      null: false
    t.datetime "date"
    t.datetime "late_connection"
    t.integer  "level_test"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "point",           default: 0
    t.integer  "attendance_time", default: 0
    t.integer  "interest"
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
  end

end
