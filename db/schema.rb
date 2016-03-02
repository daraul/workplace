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

ActiveRecord::Schema.define(version: 20160301121616) do

  create_table "datafiles", force: :cascade do |t|
    t.string   "filename"
    t.string   "url"
    t.integer  "todo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "datafiles", ["todo_id"], name: "index_datafiles_on_todo_id"

  create_table "todos", force: :cascade do |t|
    t.string   "title"
    t.text     "description", default: ""
    t.datetime "due",                         null: false
    t.boolean  "completed",   default: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "todos", ["user_id"], name: "index_todos_on_user_id"

  create_table "todos_todos", id: false, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
  end

  add_index "todos_todos", ["child_id"], name: "index_todos_todos_on_child_id"
  add_index "todos_todos", ["parent_id"], name: "index_todos_todos_on_parent_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
