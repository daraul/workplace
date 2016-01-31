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

ActiveRecord::Schema.define(version: 20160129154747) do

  create_table "checklists", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "checklists_checklists", id: false, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
  end

  add_index "checklists_checklists", ["child_id"], name: "index_checklists_checklists_on_child_id"
  add_index "checklists_checklists", ["parent_id"], name: "index_checklists_checklists_on_parent_id"

end
