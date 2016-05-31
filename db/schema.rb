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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160531111117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "backgrounds", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string   "name",        default: ""
    t.string   "image",       default: ""
    t.boolean  "status",      default: true
    t.boolean  "is_multiple", default: true
    t.integer  "location_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "chatrooms", ["location_id"], name: "index_chatrooms_on_location_id", using: :btree

  create_table "contact_us", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "subject",     default: ""
    t.text     "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "contact_us", ["user_id"], name: "index_contact_us_on_user_id", using: :btree

  create_table "friends", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "member_id"
    t.boolean  "is_paid",    default: false
    t.boolean  "is_block",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "friends", ["user_id"], name: "index_friends_on_user_id", using: :btree

  create_table "gadgets", force: :cascade do |t|
    t.string   "gadget_id",  default: ""
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "gadgets", ["user_id"], name: "index_gadgets_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "flag_image", default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content",    default: ""
    t.string   "media",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "static_pages", force: :cascade do |t|
    t.string   "title",      default: ""
    t.text     "content",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "plan",       default: ""
    t.integer  "user_id"
    t.boolean  "is_paid",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                default: ""
    t.string   "username",             default: ""
    t.string   "full_name",            default: ""
    t.string   "fb_location",          default: ""
    t.string   "image",                default: ""
    t.string   "profile_status",       default: ""
    t.boolean  "is_active",            default: true
    t.string   "fb_id",                default: ""
    t.string   "authentication_token", default: ""
    t.boolean  "is_subscribed",        default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users_chatrooms", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.integer  "background_id"
    t.boolean  "is_notified",   default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "users_chatrooms", ["background_id"], name: "index_users_chatrooms_on_background_id", using: :btree
  add_index "users_chatrooms", ["chatroom_id"], name: "index_users_chatrooms_on_chatroom_id", using: :btree
  add_index "users_chatrooms", ["user_id"], name: "index_users_chatrooms_on_user_id", using: :btree

  create_table "users_locations", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_id"
  end

  create_table "users_messages_chats", force: :cascade do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.boolean  "is_read",     default: false
    t.boolean  "is_delete",   default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users_messages_chats", ["chatroom_id"], name: "index_users_messages_chats_on_chatroom_id", using: :btree
  add_index "users_messages_chats", ["message_id"], name: "index_users_messages_chats_on_message_id", using: :btree
  add_index "users_messages_chats", ["user_id"], name: "index_users_messages_chats_on_user_id", using: :btree

  add_foreign_key "chatrooms", "locations"
  add_foreign_key "contact_us", "users"
  add_foreign_key "friends", "users"
  add_foreign_key "gadgets", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "users_chatrooms", "backgrounds"
  add_foreign_key "users_chatrooms", "chatrooms"
  add_foreign_key "users_chatrooms", "users"
  add_foreign_key "users_messages_chats", "chatrooms"
  add_foreign_key "users_messages_chats", "messages"
  add_foreign_key "users_messages_chats", "users"
end
