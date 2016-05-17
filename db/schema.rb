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

ActiveRecord::Schema.define(version: 20160516224004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "logo"
    t.text     "url"
    t.integer  "size"
    t.string   "industry"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  create_table "contact_us", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.integer "phone_number"
    t.text    "description"
    t.integer "user_id"
  end

  add_index "contact_us", ["user_id"], name: "index_contact_us_on_user_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "years_of_experience"
    t.integer  "city_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "status",              default: 0
    t.string   "education"
    t.string   "department"
    t.integer  "salary"
    t.string   "job_type"
    t.integer  "company_id"
    t.string   "slug"
  end

  add_index "jobs", ["city_id"], name: "index_jobs_on_city_id", using: :btree
  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "password_confirmation"
    t.string   "email"
    t.integer  "role",                  default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "users_jobs", force: :cascade do |t|
    t.integer  "status",       default: 0
    t.text     "resume"
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "cover_letter"
  end

  add_index "users_jobs", ["job_id"], name: "index_users_jobs_on_job_id", using: :btree
  add_index "users_jobs", ["user_id"], name: "index_users_jobs_on_user_id", using: :btree

  add_foreign_key "contact_us", "users"
  add_foreign_key "jobs", "cities"
  add_foreign_key "jobs", "companies"
  add_foreign_key "users_jobs", "jobs"
  add_foreign_key "users_jobs", "users"
end
