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

ActiveRecord::Schema[7.0].define(version: 2022_04_14_200147) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "code"
  end

  create_table "reservation_segments", force: :cascade do |t|
    t.string "reservation_id"
    t.string "segment_type"
    t.integer "rank"
    t.string "origin"
    t.string "destination"
    t.datetime "start_at"
    t.datetime "end_at"
    t.bigint "city_id"
    t.bigint "user_id"
    t.bigint "trip_id"
    t.index ["city_id"], name: "index_reservation_segments_on_city_id"
    t.index ["trip_id"], name: "index_reservation_segments_on_trip_id"
    t.index ["user_id"], name: "index_reservation_segments_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "completed", default: false
    t.bigint "user_id"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_trips_on_city_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_users_on_city_id"
  end

end
