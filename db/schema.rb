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

ActiveRecord::Schema.define(:version => 20121220074454) do

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "email"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "reportsto"
  end

  create_table "employees_connections", :id => false, :force => true do |t|
    t.integer "employee_a_id", :null => false
    t.integer "employee_b_id", :null => false
  end

  create_table "employees_roles", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "employee_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
