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

ActiveRecord::Schema.define(version: 20171222084026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_task_attachments", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "task_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_file_id"], name: "index_file_task_attachments_on_task_file_id"
    t.index ["task_id", "task_file_id"], name: "index_file_task_attachments_on_task_id_and_task_file_id", unique: true
    t.index ["task_id"], name: "index_file_task_attachments_on_task_id"
  end

  create_table "task_files", force: :cascade do |t|
    t.string "attached_file", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "task_name", null: false
    t.text "description", default: "", null: false
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_done", default: false, null: false
    t.index ["is_done"], name: "index_tasks_on_is_done"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "crypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "file_task_attachments", "task_files"
  add_foreign_key "file_task_attachments", "tasks"
  add_foreign_key "tasks", "users"
end
