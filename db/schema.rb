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

ActiveRecord::Schema.define(version: 20131124044935) do

  create_table "cem_lev", primary_key: "id_cem_lev", force: true do |t|
    t.string    "cem_name",                                          default: ""
    t.integer   "reg_num",                                           default: 0
    t.integer   "site_type",                                         default: 0
    t.integer   "active",                                            default: 0
    t.integer   "public",                                            default: 0
    t.string    "rel_lit",       limit: 45,                          default: ""
    t.integer   "county",                                            default: 0
    t.string    "loc_auth",                                          default: "0"
    t.string    "parish",                                            default: "0"
    t.string    "address",       limit: 45,                          default: ""
    t.string    "post_code",     limit: 7,                           default: ""
    t.decimal   "lat",                      precision: 16, scale: 0, default: 0
    t.decimal   "long",                     precision: 16, scale: 0, default: 0
    t.integer   "situation",                                         default: 0
    t.integer   "sur_land",                                          default: 0
    t.integer   "ext",                                               default: 0
    t.integer   "enclosed",                                          default: 0
    t.integer   "num_entrance",                                      default: 0
    t.integer   "ent_dec",                                           default: 0
    t.integer   "intramural",                                        default: 0
    t.integer   "vandalism",                                         default: 0
    t.integer   "litter",                                            default: 0
    t.integer   "landscaping",                                       default: 0
    t.integer   "gen_condition",                                     default: 0
    t.string    "owner",         limit: 45,                          default: ""
    t.string    "maintain",      limit: 45,                          default: ""
    t.string    "groups",        limit: 45,                          default: ""
    t.integer   "care",                                              default: 0
    t.string    "notes",                                             default: ""
    t.integer   "contr_rec_id"
    t.string    "approved",      limit: 1,                           default: ""
    t.string    "photo_URL",                                         default: ""
    t.integer   "county_id"
    t.integer   "surveyor_id"
    t.timestamp "date_created",                                                    null: false
    t.timestamp "date_updated",                                                    null: false
  end

  add_index "cem_lev", ["contr_rec_id"], name: "fk_cem_lev_contributer_idx", using: :btree
  add_index "cem_lev", ["county_id"], name: "fk_cem_lev_county1_idx", using: :btree
  add_index "cem_lev", ["surveyor_id"], name: "fk_cem_lev_surveyor1_idx", using: :btree

  create_table "contributor", primary_key: "id_contr_rec", force: true do |t|
    t.string    "name",         limit: 45
    t.integer   "ex_rec_id"
    t.integer   "contr_id"
    t.timestamp "date_created",            null: false
  end

  create_table "county", primary_key: "id_county", force: true do |t|
    t.string    "name",         limit: 45, null: false
    t.integer   "contr_rec_id"
    t.timestamp "date_created",            null: false
    t.timestamp "date_updated",            null: false
  end

  add_index "county", ["contr_rec_id"], name: "fk_county_contributor1_idx", using: :btree
  add_index "county", ["name"], name: "name_UNIQUE", unique: true, using: :btree

  create_table "databases", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "direction", primary_key: "id_direction", force: true do |t|
    t.binary  "N",            limit: 1
    t.binary  "S",            limit: 1
    t.binary  "E",            limit: 1
    t.binary  "W",            limit: 1
    t.binary  "U",            limit: 1
    t.binary  "D",            limit: 1
    t.binary  "All",          limit: 1
    t.integer "land_feat_id",           null: false
  end

  add_index "direction", ["land_feat_id"], name: "fk_direction_land_feat1_idx", using: :btree

  create_table "indiv_lev", primary_key: "id_indiv_lev", force: true do |t|
    t.string    "sex",          limit: 2
    t.string    "first_name",   limit: 45
    t.string    "last_name",    limit: 45
    t.date      "birth_date"
    t.date      "death_date"
    t.string    "occupation",   limit: 45
    t.string    "birth_place",  limit: 45
    t.integer   "contr_rec_id"
    t.string    "approved",     limit: 1
    t.string    "photo_URL"
    t.integer   "cem_lev_id"
    t.text      "notes"
    t.integer   "county_id"
    t.integer   "surveyor_id"
    t.timestamp "date_created",            null: false
    t.timestamp "date_updated",            null: false
  end

  add_index "indiv_lev", ["cem_lev_id"], name: "fk_indiv_lev_cem_lev1_idx", using: :btree
  add_index "indiv_lev", ["contr_rec_id"], name: "fk_indiv_lev_contributer1_idx", using: :btree
  add_index "indiv_lev", ["county_id"], name: "fk_indiv_lev_county1_idx", using: :btree
  add_index "indiv_lev", ["surveyor_id"], name: "fk_indiv_lev_surveyor1_idx", using: :btree

  create_table "land_feat", primary_key: "id_land_feat", force: true do |t|
    t.integer "mon_level_id_mon_level",            null: false
    t.string  "feat_type",              limit: 45, null: false
  end

  add_index "land_feat", ["mon_level_id_mon_level"], name: "fk_land_feat_mon_level1_idx", using: :btree

  create_table "mon_level", primary_key: "id_mon_level", force: true do |t|
    t.string    "exposure",      limit: 23
    t.string    "exp_faces",     limit: 4
    t.string    "face_orient",   limit: 1
    t.integer   "material"
    t.integer   "insc_tech"
    t.integer   "paint"
    t.integer   "num_block"
    t.integer   "dim_height"
    t.integer   "dim_width"
    t.integer   "dim_depth"
    t.integer   "foundation"
    t.integer   "class"
    t.integer   "decor"
    t.integer   "insc_det"
    t.string    "insc_transc",   limit: 45
    t.integer   "shape"
    t.integer   "num_indiv"
    t.integer   "add_feat"
    t.integer   "cond_move"
    t.integer   "cond_break"
    t.integer   "cond_chip"
    t.integer   "cond_rep"
    t.integer   "cond_veg"
    t.integer   "grass"
    t.string    "animals",       limit: 45
    t.string    "people",        limit: 45
    t.integer   "decay"
    t.string    "mem_date",      limit: 45
    t.string    "decay_factors", limit: 45
    t.integer   "contr_rec_id"
    t.string    "approved",      limit: 1
    t.string    "photo_URL",     limit: 45
    t.integer   "surveyor_id"
    t.integer   "county_id"
    t.timestamp "date_created",             null: false
    t.timestamp "date_updated",             null: false
  end

  add_index "mon_level", ["contr_rec_id"], name: "fk_mon_level_contributer1_idx", using: :btree
  add_index "mon_level", ["county_id"], name: "fk_mon_level_county1_idx", using: :btree
  add_index "mon_level", ["surveyor_id"], name: "fk_mon_level_surveyor1_idx", using: :btree

  create_table "surveyor", primary_key: "id_surveyor", force: true do |t|
    t.string    "first_name",     limit: 45
    t.string    "last_name",      limit: 45
    t.string    "organization",   limit: 45
    t.date      "date_of_survey"
    t.string    "email",          limit: 45
    t.integer   "res_prox"
    t.string    "cem_assoc",      limit: 45
    t.timestamp "date_created",              null: false
    t.timestamp "date_updated",              null: false
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
