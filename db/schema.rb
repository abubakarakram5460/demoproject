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

ActiveRecord::Schema.define(version: 20191030120648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.datetime "deadline"
    t.datetime "date"
    t.string "screenshot"
    t.string "bugtype"
    t.string "descryption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.integer "developer_id"
    t.integer "status"
    t.bigint "projectcode_id"
    t.index ["projectcode_id"], name: "index_bugs_on_projectcode_id"
  end

  create_table "projectcodes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.index ["name"], name: "index_projectcodes_on_name", unique: true
  end

  create_table "userprojects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectcode_id"
    t.bigint "user_id"
    t.string "usertype"
    t.index ["projectcode_id"], name: "index_userprojects_on_projectcode_id"
    t.index ["user_id"], name: "index_userprojects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "type"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bugs", "projectcodes"
  add_foreign_key "userprojects", "projectcodes"
  add_foreign_key "userprojects", "users"
end
