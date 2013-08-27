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

ActiveRecord::Schema.define(version: 20130827105018) do

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
    t.string   "type"
    t.integer  "count"
    t.integer  "remain"
    t.string   "local"
    t.string   "interest"
    t.integer  "sexual"
    t.integer  "facebook"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_introduce_videos", force: true do |t|
    t.string   "url"
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

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "facebook"
    t.string   "password_digest", null: false
    t.string   "nickname",        null: false
    t.string   "recommend"
    t.integer  "sex"
    t.date     "birth"
    t.string   "address"
    t.string   "mobile",          null: false
    t.datetime "date"
    t.datetime "late_connection"
    t.integer  "level_test"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
