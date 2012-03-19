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

ActiveRecord::Schema.define(:version => 20120319054644) do

  create_table "advertisements", :force => true do |t|
    t.string   "company"
    t.string   "item_name"
    t.decimal  "unit_price", :precision => 10, :scale => 0
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.integer  "sold"
  end

  create_table "circle_members", :force => true do |t|
    t.integer  "circle_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circle_members", ["circle_id"], :name => "fk1_circle_members"
  add_index "circle_members", ["user_id"], :name => "fk2_circle_members"

  create_table "circles", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circles", ["user_id"], :name => "fk_circles"

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "fk1_comments"
  add_index "comments", ["user_id"], :name => "fk2_comments"

  create_table "friend_requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "requester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_requests", ["requester_id"], :name => "fk2_friend_requests"
  add_index "friend_requests", ["user_id"], :name => "fk1_friend_requests"

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "fu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["fu_id"], :name => "fk2_friends"
  add_index "friends", ["user_id"], :name => "fk1_friends"

  create_table "group_members", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderator"
  end

  add_index "group_members", ["group_id"], :name => "fk1_group_members"
  add_index "group_members", ["user_id"], :name => "fk2_group_members"

  create_table "group_requests", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_requests", ["group_id"], :name => "fk1_group_requests"
  add_index "group_requests", ["user_id"], :name => "fk2_group_requests"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["user_id"], :name => "fk_groups"

  create_table "message_receivers", :force => true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_receivers", ["message_id"], :name => "fk1_message_receivers"
  add_index "message_receivers", ["user_id"], :name => "fk2_message_receivers"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id"], :name => "fk_messages"

  create_table "pages", :force => true do |t|
    t.integer  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["page_id"], :name => "fk2_posts"
  add_index "posts", ["user_id"], :name => "fk1_posts"

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.string   "interest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["user_id"], :name => "fk_preferences"

  create_table "sales", :force => true do |t|
    t.integer  "advertisement_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["advertisement_id"], :name => "fk1_sales"
  add_index "sales", ["user_id"], :name => "fk2_sales"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "day_of_birth"
    t.integer  "month_of_birth"
    t.integer  "year_of_birth"
    t.string   "gender"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

end
