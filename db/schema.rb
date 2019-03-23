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

ActiveRecord::Schema.define(version: 20190323052516) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "prefecture_id"
    t.integer  "post_number"
    t.string   "city"
    t.string   "town"
    t.string   "building"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_addresses_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "main_category_id"
    t.integer  "sub_category_id"
    t.integer  "size"
    t.integer  "brand"
    t.string   "name",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "depth"
    t.index ["main_category_id"], name: "index_categories_on_main_category_id", using: :btree
    t.index ["sub_category_id"], name: "index_categories_on_sub_category_id", using: :btree
  end

  create_table "item_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "explain",                 limit: 65535
    t.integer  "postage",                               default: 0
    t.string   "region"
    t.integer  "state",                                 default: 0
    t.integer  "shipping_date",                         default: 0
    t.integer  "size"
    t.integer  "brand_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "shipping_way",                          default: 0
    t.integer  "buyer_id"
    t.integer  "business_stats"
    t.integer  "category_id"
    t.integer  "child_category_id"
    t.integer  "grand_child_category_id"
    t.integer  "user_id"
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
    t.index ["child_category_id"], name: "index_items_on_child_category_id", using: :btree
    t.index ["grand_child_category_id"], name: "index_items_on_grand_child_category_id", using: :btree
    t.index ["name"], name: "index_items_on_name", using: :btree
    t.index ["price"], name: "index_items_on_price", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "nickname"
    t.string   "avatar"
    t.text     "profile_text",           limit: 65535
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
<<<<<<< HEAD
=======
    t.string   "provider"
    t.string   "uid"
>>>>>>> tsurutadesu/master
    t.string   "card_token"
    t.string   "customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "items", "categories"
end
