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

ActiveRecord::Schema.define(version: 20161206085848) do

  create_table "datasource_translations", force: :cascade do |t|
    t.integer  "datasource_id", limit: 4,   null: false
    t.string   "locale",        limit: 255, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",          limit: 255
    t.string   "url",           limit: 255
  end

  add_index "datasource_translations", ["datasource_id"], name: "index_datasource_translations_on_datasource_id", using: :btree
  add_index "datasource_translations", ["locale"], name: "index_datasource_translations_on_locale", using: :btree

  create_table "datasources", force: :cascade do |t|
    t.integer  "story_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "datasources", ["story_id"], name: "index_datasources_on_story_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "highlight_translations", force: :cascade do |t|
    t.integer  "highlight_id",       limit: 4,   null: false
    t.string   "locale",             limit: 255, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "title",              limit: 255
    t.string   "url",                limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "highlight_translations", ["highlight_id"], name: "index_highlight_translations_on_highlight_id", using: :btree
  add_index "highlight_translations", ["locale"], name: "index_highlight_translations_on_locale", using: :btree
  add_index "highlight_translations", ["title"], name: "index_highlight_translations_on_title", using: :btree

  create_table "highlights", force: :cascade do |t|
    t.boolean  "is_public",  default: false
    t.datetime "posted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "highlights", ["is_public"], name: "index_highlights_on_is_public", using: :btree
  add_index "highlights", ["posted_at"], name: "index_highlights_on_posted_at", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.text     "params",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: {"impressionable_type"=>nil, "impressionable_id"=>nil, "params"=>255}, using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "page_content_translations", force: :cascade do |t|
    t.integer  "page_content_id", limit: 4,     null: false
    t.string   "locale",          limit: 255,   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
  end

  add_index "page_content_translations", ["locale"], name: "index_page_content_translations_on_locale", using: :btree
  add_index "page_content_translations", ["page_content_id"], name: "index_page_content_translations_on_page_content_id", using: :btree

  create_table "page_contents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pledge_translations", force: :cascade do |t|
    t.integer  "pledge_id",   limit: 4,     null: false
    t.string   "locale",      limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "title",       limit: 255
    t.text     "why_care",    limit: 65535
    t.text     "what_it_is",  limit: 65535
    t.text     "what_you_do", limit: 65535
    t.string   "slug",        limit: 255
  end

  add_index "pledge_translations", ["locale"], name: "index_pledge_translations_on_locale", using: :btree
  add_index "pledge_translations", ["pledge_id"], name: "index_pledge_translations_on_pledge_id", using: :btree
  add_index "pledge_translations", ["slug"], name: "index_pledge_translations_on_slug", using: :btree
  add_index "pledge_translations", ["title"], name: "index_pledge_translations_on_title", using: :btree

  create_table "pledges", force: :cascade do |t|
    t.date     "posted_at"
    t.boolean  "is_public",                      default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "impressions_count",  limit: 4,   default: 0
    t.string   "slug",               limit: 255
  end

  add_index "pledges", ["impressions_count"], name: "index_pledges_on_impressions_count", using: :btree
  add_index "pledges", ["posted_at"], name: "index_pledges_on_posted_at", using: :btree
  add_index "pledges", ["slug"], name: "index_pledges_on_slug", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: :cascade do |t|
    t.integer  "story_type",             limit: 4
    t.date     "posted_at"
    t.boolean  "is_public",                          default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "thumbnail_file_name",    limit: 255
    t.string   "thumbnail_content_type", limit: 255
    t.integer  "thumbnail_file_size",    limit: 4
    t.datetime "thumbnail_updated_at"
    t.string   "slug",                   limit: 255
    t.integer  "impressions_count",      limit: 4,   default: 0
  end

  add_index "stories", ["impressions_count"], name: "index_stories_on_impressions_count", using: :btree
  add_index "stories", ["is_public"], name: "index_stories_on_is_public", using: :btree
  add_index "stories", ["posted_at"], name: "index_stories_on_posted_at", using: :btree
  add_index "stories", ["slug"], name: "index_stories_on_slug", using: :btree
  add_index "stories", ["story_type"], name: "index_stories_on_story_type", using: :btree

  create_table "story_translations", force: :cascade do |t|
    t.integer  "story_id",           limit: 4,     null: false
    t.string   "locale",             limit: 255,   null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.string   "organization",       limit: 255
    t.string   "url",                limit: 255
    t.text     "embed_code",         limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "slug",               limit: 255
  end

  add_index "story_translations", ["locale"], name: "index_story_translations_on_locale", using: :btree
  add_index "story_translations", ["slug"], name: "index_story_translations_on_slug", using: :btree
  add_index "story_translations", ["story_id"], name: "index_story_translations_on_story_id", using: :btree
  add_index "story_translations", ["title"], name: "index_story_translations_on_title", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                limit: 4
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "nickname",               limit: 255
    t.string   "avatar",                 limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "idx_users_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
