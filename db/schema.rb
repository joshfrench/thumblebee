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

ActiveRecord::Schema.define(:version => 7) do

  create_table "events", :force => true do |t|
    t.string   "name",       :limit => 200
    t.string   "slug",       :limit => 16
    t.date     "starts_on"
    t.string   "location",   :limit => 200
    t.string   "contact",    :limit => 200
    t.string   "email",      :limit => 200
    t.datetime "created_at"
  end

  add_index "events", ["slug"], :name => "index_events_on_slug"

  create_table "rides", :force => true do |t|
    t.integer  "event_id"
    t.string   "driver",      :limit => 200
    t.string   "email",       :limit => 200
    t.string   "location"
    t.integer  "seats",       :limit => 1
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "modified_at"
    t.string   "auth",        :limit => 36
    t.string   "anonymail",   :limit => 32
  end

  add_index "rides", ["anonymail"], :name => "index_rides_on_anonymail"
  add_index "rides", ["auth"], :name => "index_rides_on_auth"
  add_index "rides", ["event_id"], :name => "index_rides_on_event_id"

end
