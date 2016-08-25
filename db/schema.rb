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

ActiveRecord::Schema.define(version: 20160825053537) do

  create_table "bot_messages", force: :cascade do |t|
    t.text     "text",       limit: 65535
    t.integer  "stage",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "mid",           limit: 65535,                 null: false
    t.integer  "stage",         limit: 4,     default: 0,     null: false
    t.boolean  "questioner",                  default: false, null: false
    t.integer  "region_id",     limit: 4
    t.integer  "tmp_region_id", limit: 4,     default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

end
