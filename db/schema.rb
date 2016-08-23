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

ActiveRecord::Schema.define(version: 20160823055721) do

  create_table "keywords", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "text",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "timeshifts", force: :cascade do |t|
    t.string   "school_name",      limit: 255
    t.string   "school_name_kana", limit: 255
    t.time     "start_first"
    t.time     "finish_first"
    t.time     "start_second"
    t.time     "finish_second"
    t.time     "start_third"
    t.time     "finish_third"
    t.time     "start_forth"
    t.time     "finish_forth"
    t.time     "start_fifth"
    t.time     "finish_fifth"
    t.time     "start_sixth"
    t.time     "finish_sixth"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "timetables", force: :cascade do |t|
    t.string   "mon_first",     limit: 255
    t.string   "mon_second",    limit: 255
    t.string   "mon_third",     limit: 255
    t.string   "mon_forth",     limit: 255
    t.string   "mon_fifth",     limit: 255
    t.string   "mon_sixth",     limit: 255
    t.string   "tue_first",     limit: 255
    t.string   "tue_second",    limit: 255
    t.string   "tue_third",     limit: 255
    t.string   "tue_forth",     limit: 255
    t.string   "tue_fifth",     limit: 255
    t.string   "tue_sixth",     limit: 255
    t.string   "wed_first",     limit: 255
    t.string   "wed_second",    limit: 255
    t.string   "wed_third",     limit: 255
    t.string   "wed_forth",     limit: 255
    t.string   "wed_fifth",     limit: 255
    t.string   "wed_sixth",     limit: 255
    t.string   "thu_first",     limit: 255
    t.string   "thu_second",    limit: 255
    t.string   "thu_third",     limit: 255
    t.string   "thu_forth",     limit: 255
    t.string   "thu_fifth",     limit: 255
    t.string   "thu_sixth",     limit: 255
    t.string   "fri_first",     limit: 255
    t.string   "fri_second",    limit: 255
    t.string   "fri_third",     limit: 255
    t.string   "fri_forth",     limit: 255
    t.string   "fri_fifth",     limit: 255
    t.string   "fri_sixth",     limit: 255
    t.string   "sat_first",     limit: 255
    t.string   "sat_second",    limit: 255
    t.string   "sat_third",     limit: 255
    t.string   "sat_forth",     limit: 255
    t.string   "sat_fifth",     limit: 255
    t.string   "sat_sixth",     limit: 255
    t.string   "mid",           limit: 255
    t.integer  "timeshifts_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "mid",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
