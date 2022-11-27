# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_27_182318) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_times", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "state"
    t.string "city"
    t.string "address"
    t.string "zip"
    t.string "url"
    t.string "insta"
    t.string "twitter"
    t.string "facebook"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "closing_days", force: :cascade do |t|
    t.string "date"
    t.string "start"
    t.string "end"
    t.string "title"
    t.string "calendar_color"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configs", force: :cascade do |t|
    t.string "lang"
    t.decimal "tax"
    t.decimal "start"
    t.decimal "end"
    t.integer "interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_menus", force: :cascade do |t|
    t.integer "event_id"
    t.integer "menu_id"
    t.integer "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.time "start"
    t.time "end"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration_total"
    t.string "status"
    t.integer "price"
    t.decimal "tax"
    t.string "calendar_color"
  end

  create_table "menus", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.integer "category_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
  end

  create_table "user_statuses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "email"
    t.string "phone"
    t.string "gender"
    t.string "zip"
    t.string "state"
    t.string "city"
    t.text "address"
    t.text "note"
    t.date "birthday"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "lat"
    t.decimal "lon"
    t.boolean "admin", default: false
    t.string "line_id"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

end
