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

ActiveRecord::Schema.define(version: 20160427201822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "image_path"
  end

  create_table "commitments", force: :cascade do |t|
    t.integer "volunteer_id"
    t.integer "task_id"
  end

  add_index "commitments", ["task_id"], name: "index_commitments_on_task_id", using: :btree
  add_index "commitments", ["volunteer_id"], name: "index_commitments_on_volunteer_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date"
    t.time     "start_time"
    t.integer  "hours"
    t.integer  "city_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "status",             default: 0
    t.date     "pledge_date"
    t.string   "address"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "tasks", ["city_id"], name: "index_tasks_on_city_id", using: :btree

  create_table "volunteers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password_digest"
    t.string   "password_confirmation"
    t.string   "email"
    t.integer  "role",                  default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_foreign_key "commitments", "tasks"
  add_foreign_key "commitments", "volunteers"
  add_foreign_key "tasks", "cities"
end
