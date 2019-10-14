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

ActiveRecord::Schema.define(version: 20191014132554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.string "deadline"
    t.string "date"
    t.string "screenshot"
    t.string "type"
    t.string "status"
    t.string "descryption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectcode_id"
    t.integer "creator_id"
    t.integer "developer_id"
    t.index ["projectcode_id"], name: "index_bugs_on_projectcode_id"
  end

  create_table "projectcodes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "projectcode_id"
    t.index ["projectcode_id"], name: "index_users_on_projectcode_id"
  end

  add_foreign_key "bugs", "projectcodes"
  add_foreign_key "users", "projectcodes"
end
