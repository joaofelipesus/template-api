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

ActiveRecord::Schema[8.1].define(version: 2025_11_11_125113) do
  create_table "belts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "presences_required"
    t.datetime "updated_at", null: false
  end

  create_table "presences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_belt_id", null: false
    t.integer "current_presences_count"
    t.boolean "graduate", default: false
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["current_belt_id"], name: "index_presences_on_current_belt_id"
    t.index ["student_id"], name: "index_presences_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "presences", "current_belts"
  add_foreign_key "presences", "students"
end
