# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090714153220) do

  create_table "assignments", :force => true do |t|
    t.integer  "engineer_id"
    t.integer  "project_id"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "engineers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
    t.string   "role"
  end

  create_table "managers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "weeks", :force => true do |t|
    t.integer  "number"
    t.datetime "startdate"
    t.datetime "enddate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_count"
  end

  add_index "weeks", ["enddate"], :name => "index_weeks_on_enddate", :unique => true
  add_index "weeks", ["startdate"], :name => "index_weeks_on_startdate", :unique => true

end