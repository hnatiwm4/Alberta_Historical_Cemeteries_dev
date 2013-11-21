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

ActiveRecord::Schema.define(version: 20131119070756) do

  create_table "cem_lev", primary_key: "id_cem_lev", force: true do |t|
    t.string    "cem_name",      limit: 45,                          default: "", null: false
    t.integer   "reg_num",                                           default: 0,  null: false
    t.integer   "site_type",                                         default: 0,  null: false
    t.integer   "active",                                            default: 0,  null: false
    t.integer   "public",                                            default: 0,  null: false
    t.string    "rel_lit",       limit: 45,                          default: "", null: false
    t.integer   "county",                                            default: 0,  null: false
    t.integer   "loc_auth",                                          default: 0,  null: false
    t.integer   "parish",                                            default: 0,  null: false
    t.string    "address",       limit: 45,                          default: "", null: false
    t.string    "post_code",     limit: 7,                           default: "", null: false
    t.decimal   "lat",                      precision: 16, scale: 0, default: 0,  null: false
    t.decimal   "long",                     precision: 16, scale: 0, default: 0,  null: false
    t.integer   "situation",                                         default: 0,  null: false
    t.integer   "sur_land",                                          default: 0,  null: false
    t.integer   "ext",                                               default: 0,  null: false
    t.integer   "enclosed",                                          default: 0,  null: false
    t.integer   "num_entrance",                                      default: 0,  null: false
    t.integer   "ent_dec",                                           default: 0,  null: false
    t.integer   "intramural",                                        default: 0,  null: false
    t.integer   "vandalism",                                         default: 0,  null: false
    t.integer   "litter",                                            default: 0,  null: false
    t.integer   "landscaping",                                       default: 0,  null: false
    t.integer   "gen_condition",                                     default: 0,  null: false
    t.string    "owner",         limit: 45,                          default: "", null: false
    t.string    "maintain",      limit: 45,                          default: "", null: false
    t.string    "groups",        limit: 45,                          default: "", null: false
    t.integer   "care",                                              default: 0,  null: false
    t.string    "notes",                                             default: "", null: false
    t.integer   "contr_rec_id"
    t.string    "approved",      limit: 1,                           default: "", null: false
    t.string    "photo_URL",     limit: 45,                          default: "", null: false
    t.integer   "county_id"
    t.integer   "surveyor_id"
    t.timestamp "date_updated",                                                   null: false
    t.timestamp "date_created",                                                   null: false
  end

  add_index "cem_lev", ["contr_rec_id"], name: "fk_cem_lev_contributer_idx", using: :btree
  add_index "cem_lev", ["county_id"], name: "fk_cem_lev_county1_idx", using: :btree
  add_index "cem_lev", ["surveyor_id"], name: "fk_cem_lev_surveyor1_idx", using: :btree

  create_table "cem_levs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributor", primary_key: "id_contr_rec", force: true do |t|
    t.string  "name",      limit: 45, null: false
    t.integer "ex_rec_id",            null: false
    t.integer "contr_id",             null: false
  end

  create_table "county", primary_key: "id_county", force: true do |t|
    t.string  "name",         limit: 45, null: false
    t.integer "contr_rec_id"
  end

  add_index "county", ["contr_rec_id"], name: "fk_county_contributor1_idx", using: :btree

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
    t.string    "sex",          limit: 2,  null: false
    t.string    "first_name",   limit: 45, null: false
    t.string    "last_name",    limit: 45, null: false
    t.date      "birth_date",              null: false
    t.date      "death_date",              null: false
    t.string    "occupation",   limit: 45, null: false
    t.string    "birth_place",  limit: 45, null: false
    t.integer   "contr_rec_id"
    t.string    "approved",     limit: 1,  null: false
    t.string    "photo_URL",    limit: 45, null: false
    t.integer   "cem_lev_id"
    t.string    "notes",                   null: false
    t.integer   "county_id"
    t.integer   "surveyor_id"
    t.timestamp "date_updated",            null: false
    t.timestamp "date_created",            null: false
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
    t.string    "exposure",      limit: 23, null: false
    t.string    "exp_faces",     limit: 4,  null: false
    t.string    "face_orient",   limit: 1,  null: false
    t.integer   "material",                 null: false
    t.integer   "insc_tech",                null: false
    t.integer   "paint",                    null: false
    t.integer   "num_block",                null: false
    t.integer   "dim_height",               null: false
    t.integer   "dim_width",                null: false
    t.integer   "dim_depth",                null: false
    t.integer   "foundation",               null: false
    t.integer   "class",                    null: false
    t.integer   "decor",                    null: false
    t.integer   "insc_det",                 null: false
    t.string    "insc_transc",   limit: 45, null: false
    t.integer   "shape",                    null: false
    t.integer   "num_indiv",                null: false
    t.integer   "add_feat",                 null: false
    t.integer   "cond_move",                null: false
    t.integer   "cond_break",               null: false
    t.integer   "cond_chip",                null: false
    t.integer   "cond_rep",                 null: false
    t.integer   "cond_veg",                 null: false
    t.integer   "grass",                    null: false
    t.string    "animals",       limit: 45, null: false
    t.string    "people",        limit: 45, null: false
    t.integer   "decay",                    null: false
    t.string    "mem_date",      limit: 45, null: false
    t.string    "decay_factors", limit: 45, null: false
    t.integer   "contr_rec_id"
    t.string    "approved",      limit: 1,  null: false
    t.string    "photo_URL",     limit: 45, null: false
    t.integer   "surveyor_id"
    t.integer   "county_id"
    t.timestamp "date_updated",             null: false
    t.timestamp "date_created",             null: false
  end

  add_index "mon_level", ["contr_rec_id"], name: "fk_mon_level_contributer1_idx", using: :btree
  add_index "mon_level", ["county_id"], name: "fk_mon_level_county1_idx", using: :btree
  add_index "mon_level", ["surveyor_id"], name: "fk_mon_level_surveyor1_idx", using: :btree

  create_table "surveyor", primary_key: "id_surveyor", force: true do |t|
    t.string  "first_name",     limit: 45, null: false
    t.string  "last_name",      limit: 45, null: false
    t.string  "organization",   limit: 45, null: false
    t.date    "date_of_survey",            null: false
    t.string  "email",          limit: 45, null: false
    t.integer "res_prox",                  null: false
    t.string  "cem_assoc",      limit: 45, null: false
  end

end
