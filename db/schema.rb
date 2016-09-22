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

ActiveRecord::Schema.define(version: 20160916040713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "bookmarkable_id"
    t.string   "bookmarkable_type"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["bookmarkable_id", "bookmarkable_type"], name: "index_bookmarks_on_bookmarkable_id_and_bookmarkable_type", using: :btree
    t.index ["user_id"], name: "index_bookmarks_on_user_id", using: :btree
  end

  create_table "interests", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["follower_id", "tag_id"], name: "index_interests_on_follower_id_and_tag_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_interests_on_follower_id", using: :btree
    t.index ["tag_id"], name: "index_interests_on_tag_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.string   "action"
    t.datetime "read_at"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["actor_id"], name: "index_notifications_on_actor_id", using: :btree
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.text     "body"
    t.integer  "stories_id"
    t.integer  "user_id"
    t.integer  "likes_count", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["stories_id"], name: "index_responses_on_stories_id", using: :btree
    t.index ["user_id"], name: "index_responses_on_user_id", using: :btree
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "picture"
    t.integer  "user_id"
    t.boolean  "featured",     default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "lead"
    t.integer  "likes_count",  default: 0
    t.datetime "published_at"
    t.index ["user_id"], name: "index_stories_on_user_id", using: :btree
  end

  create_table "tag_relationships", force: :cascade do |t|
    t.integer  "tag_id",                     null: false
    t.integer  "related_tag_id",             null: false
    t.integer  "relevance",      default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["related_tag_id"], name: "index_tag_relationships_on_related_tag_id", using: :btree
    t.index ["tag_id", "related_tag_id"], name: "index_tag_relationships_on_tag_id_and_related_tag_id", unique: true, using: :btree
    t.index ["tag_id"], name: "index_tag_relationships_on_tag_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "storie_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["storie_id"], name: "index_taggings_on_storie_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "lowercase_name"
    t.boolean  "featured",       default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
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
    t.string   "avatar"
    t.text     "description"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bookmarks", "users"
  add_foreign_key "responses", "stories", column: "stories_id"
  add_foreign_key "responses", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "taggings", "stories", column: "storie_id"
  add_foreign_key "taggings", "tags"
end
