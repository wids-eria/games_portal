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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140519192820) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "localpath"
    t.string   "lesson_plan_file_name"
    t.string   "lesson_plan_content_type"
    t.integer  "lesson_plan_file_size"
    t.datetime "lesson_plan_updated_at"
    t.string   "cirriculum_file_name"
    t.string   "cirriculum_content_type"
    t.integer  "cirriculum_file_size"
    t.datetime "cirriculum_updated_at"
    t.string   "microsite"
    t.string   "external_download"
    t.string   "token"
  end

  create_table "surveys", :force => true do |t|
    t.string   "url"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "consented",   :default => false
    t.string   "player_name"
    t.string   "token"
    t.boolean  "guest",       :default => false
    t.boolean  "admin"
    t.string   "auth_token"
  end

end
