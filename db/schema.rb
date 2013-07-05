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

ActiveRecord::Schema.define(version: 20130630212901) do

  create_table "authors", force: true do |t|
    t.integer  "twitter_id",        limit: 8
    t.text     "screen_name"
    t.text     "name"
    t.text     "description"
    t.text     "location"
    t.text     "profile_image_url"
    t.text     "url"
    t.integer  "followers_count",             default: 0
    t.integer  "statuses_count",              default: 0
    t.integer  "friends_count",               default: 0
    t.datetime "joined_twitter_at"
    t.text     "lang"
    t.text     "time_zone"
    t.boolean  "verified"
    t.boolean  "following"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["followers_count"], name: "index_authors_on_followers_count", using: :btree
  add_index "authors", ["screen_name"], name: "index_authors_on_screen_name", using: :btree
  add_index "authors", ["twitter_id"], name: "index_authors_on_twitter_id", unique: true, using: :btree

  create_table "tweets", force: true do |t|
    t.integer  "twitter_id",            limit: 8
    t.text     "text"
    t.integer  "in_reply_to_user_id",   limit: 8
    t.integer  "in_reply_to_status_id", limit: 8
    t.text     "source"
    t.text     "lang"
    t.integer  "favorite_count",                  default: 0
    t.integer  "retweet_count",                   default: 0
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["author_id"], name: "index_tweets_on_author_id", using: :btree
  add_index "tweets", ["twitter_id"], name: "index_tweets_on_twitter_id", unique: true, using: :btree

end
