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

ActiveRecord::Schema.define(version: 20150421193054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventure_hosts", force: :cascade do |t|
    t.integer "user_id",      null: false
    t.integer "adventure_id", null: false
  end

  add_index "adventure_hosts", ["adventure_id"], name: "index_adventure_hosts_on_adventure_id", using: :btree
  add_index "adventure_hosts", ["user_id", "adventure_id"], name: "index_adventure_hosts_on_user_id_and_adventure_id", unique: true, using: :btree
  add_index "adventure_hosts", ["user_id"], name: "index_adventure_hosts_on_user_id", using: :btree

  create_table "adventure_memberships", force: :cascade do |t|
    t.string  "status",       default: "invited", null: false
    t.integer "user_id",                          null: false
    t.integer "adventure_id",                     null: false
  end

  add_index "adventure_memberships", ["adventure_id"], name: "index_adventure_memberships_on_adventure_id", using: :btree
  add_index "adventure_memberships", ["user_id", "adventure_id"], name: "index_adventure_memberships_on_user_id_and_adventure_id", unique: true, using: :btree
  add_index "adventure_memberships", ["user_id"], name: "index_adventure_memberships_on_user_id", using: :btree

  create_table "adventures", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "description",                     null: false
    t.string   "location"
    t.date     "date"
    t.time     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_adventure", default: true, null: false
    t.time     "end_time"
    t.datetime "poll_opened_at"
  end

  add_index "adventures", ["date"], name: "index_adventures_on_date", using: :btree
  add_index "adventures", ["name"], name: "index_adventures_on_name", using: :btree

  create_table "proposed_time_votes", force: :cascade do |t|
    t.integer "proposed_time_id",        null: false
    t.integer "adventure_membership_id", null: false
  end

  create_table "proposed_times", force: :cascade do |t|
    t.date    "date",         null: false
    t.time    "start_time",   null: false
    t.time    "end_time",     null: false
    t.integer "adventure_id", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.string  "name",                    null: false
    t.integer "adventure_id",            null: false
    t.integer "adventure_membership_id"
    t.integer "adventure_host_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
