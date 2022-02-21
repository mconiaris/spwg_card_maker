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

ActiveRecord::Schema.define(version: 2022_02_21_153723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.string "name", default: "None"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name", default: "None"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wrestlers", force: :cascade do |t|
    t.string "name"
    t.string "set"
    t.float "tt"
    t.float "card_rating"
    t.float "oc_prob"
    t.float "total_points"
    t.float "dq_prob"
    t.float "pa_prob"
    t.float "sub_prob"
    t.float "xx_prob"
    t.float "submission"
    t.float "tag_team_save"
    t.string "gc02"
    t.string "gc03"
    t.string "gc04"
    t.string "gc05"
    t.string "gc06"
    t.string "gc07"
    t.string "gc08"
    t.string "gc09"
    t.string "gc10"
    t.string "gc11"
    t.string "gc12"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "dc02"
    t.string "dc03"
    t.string "dc04"
    t.string "dc05"
    t.string "dc06"
    t.string "dc07"
    t.string "dc08"
    t.string "dc09"
    t.string "dc10"
    t.string "dc11"
    t.string "dc12"
    t.string "s1"
    t.string "s2"
    t.string "s3"
    t.string "s4"
    t.string "s5"
    t.string "s6"
    t.string "prioritys"
    t.string "priorityt"
    t.string "oc02"
    t.string "oc03"
    t.string "oc04"
    t.string "oc05"
    t.string "oc06"
    t.string "oc07"
    t.string "oc08"
    t.string "oc09"
    t.string "oc10"
    t.string "oc11"
    t.string "oc12"
    t.string "ro02"
    t.string "ro03"
    t.string "ro04"
    t.string "ro05"
    t.string "ro06"
    t.string "ro07"
    t.string "ro08"
    t.string "ro09"
    t.string "ro10"
    t.string "ro11"
    t.string "ro12"
    t.integer "subx"
    t.integer "suby"
    t.integer "tagy"
    t.string "specialty"
    t.string "tagx"
    t.bigint "division_id"
    t.bigint "promotion_id"
    t.boolean "template"
    t.index ["division_id"], name: "index_wrestlers_on_division_id"
    t.index ["promotion_id"], name: "index_wrestlers_on_promotion_id"
  end

  add_foreign_key "wrestlers", "divisions"
  add_foreign_key "wrestlers", "promotions"
end
