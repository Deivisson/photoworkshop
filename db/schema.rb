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

ActiveRecord::Schema.define(version: 20160207005438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_categories", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "description", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_users", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_users", ["category_id"], name: "index_categories_users_on_category_id", using: :btree
  add_index "categories_users", ["user_id"], name: "index_categories_users_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_photos", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorite_photos", ["photo_id"], name: "index_favorite_photos_on_photo_id", using: :btree
  add_index "favorite_photos", ["user_id"], name: "index_favorite_photos_on_user_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.string   "i18n_key"
    t.integer  "number",      default: 0
    t.integer  "points_from", default: 0
    t.integer  "points_to",   default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_sender_id"
    t.integer  "user_receiver_id"
    t.text     "content"
    t.boolean  "read",             default: false, null: false
    t.integer  "type_of",                          null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "notifications", ["user_receiver_id"], name: "index_notifications_on_user_receiver_id", using: :btree
  add_index "notifications", ["user_sender_id"], name: "index_notifications_on_user_sender_id", using: :btree

  create_table "photo_comments", force: :cascade do |t|
    t.integer  "user_id",                                null: false
    t.integer  "photo_id",                               null: false
    t.text     "content",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "from_workshop_activity", default: false, null: false
  end

  add_index "photo_comments", ["photo_id"], name: "index_photo_comments_on_photo_id", using: :btree
  add_index "photo_comments", ["user_id"], name: "index_photo_comments_on_user_id", using: :btree

  create_table "photo_exifs", force: :cascade do |t|
    t.integer  "photo_id",                  null: false
    t.string   "maker",         limit: 100
    t.string   "model",         limit: 100
    t.string   "lens",          limit: 100
    t.string   "orientation",   limit: 100
    t.string   "shutter_speed", limit: 100
    t.string   "aperture",      limit: 100
    t.string   "iso",           limit: 100
    t.datetime "taken_at"
    t.string   "flash",         limit: 100
    t.string   "focal_lenght",  limit: 100
    t.string   "colorsapce",    limit: 100
    t.string   "exposuremode",  limit: 100
    t.string   "whitebalance",  limit: 100
    t.integer  "imagewidth"
    t.integer  "imageheight"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_exifs", ["photo_id"], name: "index_photo_exifs_on_photo_id", using: :btree

  create_table "photo_likes", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_likes", ["photo_id"], name: "index_photo_likes_on_photo_id", using: :btree
  add_index "photo_likes", ["user_id"], name: "index_photo_likes_on_user_id", using: :btree

  create_table "photo_ratings", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "rating_criterium_id"
    t.integer  "score",                         default: 0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id"
    t.integer  "workshop_activity_response_id"
  end

  add_index "photo_ratings", ["photo_id"], name: "index_photo_ratings_on_photo_id", using: :btree
  add_index "photo_ratings", ["rating_criterium_id"], name: "index_photo_ratings_on_rating_criterium_id", using: :btree
  add_index "photo_ratings", ["user_id"], name: "index_photo_ratings_on_user_id", using: :btree
  add_index "photo_ratings", ["workshop_activity_response_id"], name: "index_photo_ratings_on_workshop_activity_response_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id",                                                   null: false
    t.integer  "category_id",                                               null: false
    t.string   "title",                         limit: 40
    t.text     "description"
    t.string   "tags",                          limit: 100
    t.string   "picture_file_name",             limit: 255
    t.string   "picture_content_type",          limit: 255
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views",                                     default: 0,     null: false
    t.integer  "likes_count",                               default: 0,     null: false
    t.integer  "workshop_activity_response_id"
    t.boolean  "cover",                                     default: false, null: false
    t.datetime "cover_at"
  end

  add_index "photos", ["category_id"], name: "index_photos_on_category_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree
  add_index "photos", ["workshop_activity_response_id"], name: "index_photos_on_workshop_activity_response_id", using: :btree

  create_table "portfolio_templates", force: :cascade do |t|
    t.string   "i18n_key",   limit: 150,                                         null: false
    t.text     "settings",                                                       null: false
    t.boolean  "free",                                           default: false, null: false
    t.decimal  "price",                  precision: 5, scale: 2, default: 0.0,   null: false
    t.boolean  "active",                                         default: true,  null: false
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "rating_criteria", force: :cascade do |t|
    t.string   "i18n_key",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "css_class"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 100
    t.string   "short_name", limit: 2
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "user_auths", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_auths", ["user_id"], name: "index_user_auths_on_user_id", using: :btree

  create_table "user_points", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "number"
    t.integer  "origin",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "photo_id"
    t.integer  "userx_id"
  end

  add_index "user_points", ["user_id"], name: "index_user_points_on_user_id", using: :btree

  create_table "user_portfolio_templates", force: :cascade do |t|
    t.integer  "user_id",               null: false
    t.integer  "portfolio_template_id", null: false
    t.boolean  "active",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "settings"
  end

  add_index "user_portfolio_templates", ["portfolio_template_id"], name: "index_user_portfolio_templates_on_portfolio_template_id", using: :btree
  add_index "user_portfolio_templates", ["user_id"], name: "index_user_portfolio_templates_on_user_id", using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "description"
    t.string   "work",                      limit: 50
    t.string   "camera",                    limit: 30
    t.string   "home_page",                 limit: 255
    t.string   "facebook",                  limit: 50
    t.string   "twitter",                   limit: 50
    t.string   "google_plus",               limit: 50
    t.string   "tumblr",                    limit: 50
    t.string   "flickr",                    limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "user_name",                 limit: 50
    t.string   "avatar_file_name",          limit: 255
    t.string   "avatar_content_type",       limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "full_name",                 limit: 100
    t.integer  "cover_photo_id"
    t.integer  "limit_upload_photo_by_day",             default: 0,     null: false
    t.boolean  "facebook_shared",                       default: false, null: false
    t.boolean  "twitter_shared",                        default: false, null: false
  end

  add_index "user_profiles", ["category_id"], name: "index_user_profiles_on_category_id", using: :btree
  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "user_relations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_relations", ["user_id"], name: "index_user_relations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "first_login",                        default: true
    t.integer  "current_points",                     default: 0,    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workshop_activities", force: :cascade do |t|
    t.integer  "workshop_id"
    t.string   "description",           limit: 100,             null: false
    t.text     "details"
    t.integer  "status",                            default: 0, null: false
    t.date     "limit_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "maximum_upload_number",             default: 1, null: false
  end

  add_index "workshop_activities", ["workshop_id"], name: "index_workshop_activities_on_workshop_id", using: :btree

  create_table "workshop_activity_responses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "workshop_activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_activity_responses", ["user_id"], name: "index_workshop_activity_responses_on_user_id", using: :btree
  add_index "workshop_activity_responses", ["workshop_activity_id"], name: "index_workshop_activity_responses_on_workshop_activity_id", using: :btree

  create_table "workshop_materials", force: :cascade do |t|
    t.integer  "workshop_id"
    t.string   "description",             limit: 100
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_materials", ["workshop_id"], name: "index_workshop_materials_on_workshop_id", using: :btree

  create_table "workshop_participants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",   default: false, null: false
    t.boolean  "in_queue",    default: false, null: false
  end

  add_index "workshop_participants", ["user_id"], name: "index_workshop_participants_on_user_id", using: :btree
  add_index "workshop_participants", ["workshop_id"], name: "index_workshop_participants_on_workshop_id", using: :btree

  create_table "workshop_plans", force: :cascade do |t|
    t.string   "i18n_key",   limit: 100
    t.text     "settings"
    t.boolean  "active",                                         default: false, null: false
    t.decimal  "value",                  precision: 5, scale: 2, default: 0.0,   null: false
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "workshops", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description",        limit: 200,                 null: false
    t.text     "details"
    t.date     "start_date",                                     null: false
    t.date     "end_date",                                       null: false
    t.integer  "vacancies_number"
    t.decimal  "value"
    t.string   "prerequisite",       limit: 255
    t.text     "goal"
    t.string   "target_audience",    limit: 255
    t.text     "term"
    t.integer  "status",                         default: 0,     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "workload",           limit: 50
    t.string   "local",              limit: 255
    t.text     "complement"
    t.text     "email_subscribe"
    t.text     "email_matriculate"
    t.boolean  "allow_queued",                   default: false, null: false
    t.boolean  "allow_pre_enrolls",              default: true,  null: false
    t.integer  "workshop_plan_id"
  end

  add_index "workshops", ["user_id"], name: "index_workshops_on_user_id", using: :btree
  add_index "workshops", ["workshop_plan_id"], name: "index_workshops_on_workshop_plan_id", using: :btree

  add_foreign_key "cities", "states", name: "cities_states"
  add_foreign_key "favorite_photos", "photos"
  add_foreign_key "favorite_photos", "users"
  add_foreign_key "notifications", "users", column: "user_receiver_id", name: "notifications_receiver_user"
  add_foreign_key "notifications", "users", column: "user_sender_id", name: "notifications_sender_user"
  add_foreign_key "photo_comments", "photos", name: "photo_comments_photo"
  add_foreign_key "photo_comments", "users", name: "photo_comments_user"
  add_foreign_key "photo_exifs", "photos", name: "fk_photos_exifs"
  add_foreign_key "photo_likes", "photos", name: "photo_likes_photos"
  add_foreign_key "photo_likes", "users", name: "photo_likes_user"
  add_foreign_key "photo_ratings", "photos"
  add_foreign_key "photo_ratings", "rating_criteria"
  add_foreign_key "photo_ratings", "users"
  add_foreign_key "photo_ratings", "workshop_activity_responses"
  add_foreign_key "photos", "categories", name: "fk_photos_category"
  add_foreign_key "photos", "users", name: "fk_photos_users"
  add_foreign_key "states", "countries", name: "states_countries"
  add_foreign_key "user_auths", "users", name: "user_auths_users"
  add_foreign_key "user_points", "users"
  add_foreign_key "user_points", "users", column: "userx_id", name: "user_points_user_x"
  add_foreign_key "user_portfolio_templates", "portfolio_templates"
  add_foreign_key "user_portfolio_templates", "users"
  add_foreign_key "user_profiles", "categories", name: "user_profiles_categories"
  add_foreign_key "user_profiles", "cities", name: "user_profiles_cities"
  add_foreign_key "user_profiles", "photos", column: "cover_photo_id", name: "user_profiles_photos"
  add_foreign_key "user_profiles", "users", name: "user_profiles_users"
  add_foreign_key "user_relations", "users", column: "user_followed_id", name: "user_relations_users_followed"
  add_foreign_key "user_relations", "users", name: "user_relations_users"
  add_foreign_key "workshop_activities", "workshops", name: "workshop_activities_workshop"
  add_foreign_key "workshop_materials", "workshops", name: "workshop_materials_workshop"
  add_foreign_key "workshop_participants", "users", name: "workshop_participants_user"
  add_foreign_key "workshop_participants", "workshops", name: "workshop_participants_workshop"
  add_foreign_key "workshops", "users", name: "workshops_user"
  add_foreign_key "workshops", "workshop_plans"
end
