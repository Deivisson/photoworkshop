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

ActiveRecord::Schema.define(version: 20150910230439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_categories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "description", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_comments", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "photo_id",   null: false
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_comments", ["photo_id"], name: "index_photo_comments_on_photo_id", using: :btree
  add_index "photo_comments", ["user_id"], name: "index_photo_comments_on_user_id", using: :btree

  create_table "photo_exifs", force: true do |t|
    t.integer  "photo_id",                  null: false
    t.string   "maker",         limit: 100
    t.string   "model",         limit: 100
    t.string   "lens",          limit: 100
    t.string   "orientation",   limit: 100
    t.string   "shutter_speed", limit: 100
    t.string   "aperture",      limit: 100
    t.string   "iso",           limit: 10
    t.datetime "taken_at"
    t.string   "flash",         limit: 100
    t.string   "focal_lenght",  limit: 20
    t.string   "colorsapce",    limit: 20
    t.string   "exposuremode",  limit: 20
    t.string   "whitebalance",  limit: 20
    t.integer  "imagewidth"
    t.integer  "imageheight"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_exifs", ["photo_id"], name: "index_photo_exifs_on_photo_id", using: :btree

  create_table "photo_likes", force: true do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_likes", ["photo_id"], name: "index_photo_likes_on_photo_id", using: :btree
  add_index "photo_likes", ["user_id"], name: "index_photo_likes_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "user_id",                                               null: false
    t.integer  "category_id",                                           null: false
    t.string   "title",                         limit: 40
    t.text     "description"
    t.string   "tags",                          limit: 100
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views",                                     default: 0, null: false
    t.integer  "likes_count",                               default: 0, null: false
    t.integer  "workshop_activity_response_id"
  end

  add_index "photos", ["category_id"], name: "index_photos_on_category_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree
  add_index "photos", ["workshop_activity_response_id"], name: "index_photos_on_workshop_activity_response_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "states", force: true do |t|
    t.string   "name",       limit: 100
    t.string   "short_name", limit: 2
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "user_auths", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_auths", ["user_id"], name: "index_user_auths_on_user_id", using: :btree

  create_table "user_profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "description"
    t.string   "work",                limit: 50
    t.string   "camera",              limit: 30
    t.string   "home_page"
    t.string   "facebook",            limit: 50
    t.string   "twitter",             limit: 50
    t.string   "google_plus",         limit: 50
    t.string   "tumblr",              limit: 50
    t.string   "flickr",              limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "user_name",           limit: 50
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "full_name",           limit: 100
    t.integer  "cover_photo_id"
  end

  add_index "user_profiles", ["category_id"], name: "index_user_profiles_on_category_id", using: :btree
  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "user_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_relations", ["user_id"], name: "index_user_relations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workshop_activities", force: true do |t|
    t.integer  "workshop_id"
    t.string   "description", limit: 100,             null: false
    t.text     "details"
    t.integer  "status",                  default: 0, null: false
    t.date     "limit_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_activities", ["workshop_id"], name: "index_workshop_activities_on_workshop_id", using: :btree

  create_table "workshop_activity_responses", force: true do |t|
    t.integer  "user_id"
    t.integer  "workshop_activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_activity_responses", ["user_id"], name: "index_workshop_activity_responses_on_user_id", using: :btree
  add_index "workshop_activity_responses", ["workshop_activity_id"], name: "index_workshop_activity_responses_on_workshop_activity_id", using: :btree

  create_table "workshop_materials", force: true do |t|
    t.integer  "workshop_id"
    t.string   "description",             limit: 100
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_materials", ["workshop_id"], name: "index_workshop_materials_on_workshop_id", using: :btree

  create_table "workshop_participants", force: true do |t|
    t.integer  "user_id"
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",   default: false, null: false
  end

  add_index "workshop_participants", ["user_id"], name: "index_workshop_participants_on_user_id", using: :btree
  add_index "workshop_participants", ["workshop_id"], name: "index_workshop_participants_on_workshop_id", using: :btree

  create_table "workshops", force: true do |t|
    t.integer  "user_id"
    t.string   "description",        limit: 200,             null: false
    t.text     "details"
    t.date     "start_date",                                 null: false
    t.date     "end_date",                                   null: false
    t.integer  "vacancies_number"
    t.decimal  "value"
    t.string   "prerequisite"
    t.text     "goal"
    t.string   "target_audience"
    t.text     "term"
    t.integer  "status",                         default: 0, null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "workload",           limit: 50
    t.string   "local"
    t.text     "complement"
    t.text     "email_subscribe"
    t.text     "email_matriculate"
  end

  add_index "workshops", ["user_id"], name: "index_workshops_on_user_id", using: :btree

  add_foreign_key "cities", "states", name: "cities_states"

  add_foreign_key "photo_comments", "photos", name: "photo_comments_photo"
  add_foreign_key "photo_comments", "users", name: "photo_comments_user"

  add_foreign_key "photo_exifs", "photos", name: "fk_photos_exifs"

  add_foreign_key "photo_likes", "photos", name: "photo_likes_photos"
  add_foreign_key "photo_likes", "users", name: "photo_likes_user"

  add_foreign_key "photos", "categories", name: "fk_photos_category"
  add_foreign_key "photos", "users", name: "fk_photos_users"

  add_foreign_key "states", "countries", name: "states_countries"

  add_foreign_key "user_auths", "users", name: "user_auths_users"

  add_foreign_key "user_profiles", "categories", name: "user_profiles_categories"
  add_foreign_key "user_profiles", "cities", name: "user_profiles_cities"
  add_foreign_key "user_profiles", "photos", name: "user_profiles_photos", column: "cover_photo_id"
  add_foreign_key "user_profiles", "users", name: "user_profiles_users"

  add_foreign_key "user_relations", "users", name: "user_relations_users"
  add_foreign_key "user_relations", "users", name: "user_relations_users_followed", column: "user_followed_id"

  add_foreign_key "workshop_activities", "workshops", name: "workshop_activities_workshop"

  add_foreign_key "workshop_materials", "workshops", name: "workshop_materials_workshop"

  add_foreign_key "workshop_participants", "users", name: "workshop_participants_user"
  add_foreign_key "workshop_participants", "workshops", name: "workshop_participants_workshop"

  add_foreign_key "workshops", "users", name: "workshops_user"

end
