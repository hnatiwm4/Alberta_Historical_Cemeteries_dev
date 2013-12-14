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

ActiveRecord::Schema.define(version: 20131211172053) do

  create_table "active", primary_key: "id_active", force: true do |t|
    t.string  "select",      limit: 17
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "active", ["cem_lev_id"], name: "fk_active_cem_lev1_idx", using: :btree

  create_table "animals", primary_key: "id_animals", force: true do |t|
    t.string  "select",       limit: 3
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "animals", ["mon_level_id"], name: "fk_animals_mon_level1_idx", using: :btree

  create_table "breakage", primary_key: "id_breakage", force: true do |t|
    t.string  "select",       limit: 17
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "breakage", ["mon_level_id"], name: "fk_breakage_mon_level1_idx", using: :btree

  create_table "care/ownership", primary_key: "id_care/ownership", force: true do |t|
    t.string  "owner",           limit: 45
    t.string  "maintained_by",   limit: 45
    t.string  "groups_involved", limit: 45
    t.integer "cem_lev_id",                 null: false
  end

  add_index "care/ownership", ["cem_lev_id"], name: "fk_care/ownership_cem_lev1_idx", using: :btree

  create_table "care_priority", primary_key: "id_care_priority", force: true do |t|
    t.string  "select",     limit: 60
    t.integer "priority"
    t.integer "cem_lev_id",            null: false
  end

  add_index "care_priority", ["cem_lev_id"], name: "fk_care_priority_cem_lev1_idx", using: :btree

  create_table "cem_lev", primary_key: "id_cem_lev", force: true do |t|
    t.string    "cem_name"
    t.integer   "reg_num"
    t.string    "public",       limit: 3
    t.string    "rel_lit"
    t.integer   "county"
    t.string    "loc_auth"
    t.string    "parish"
    t.string    "address"
    t.string    "post_code",    limit: 7
    t.decimal   "lat",                     precision: 18, scale: 12
    t.decimal   "long",                    precision: 18, scale: 12
    t.string    "ext",          limit: 3
    t.integer   "num_entrance"
    t.string    "intramural",   limit: 33
    t.string    "notes"
    t.integer   "contr_rec_id"
    t.string    "approved",     limit: 1
    t.string    "photo_URL"
    t.integer   "county_id"
    t.integer   "surveyor_id"
    t.timestamp "date_updated",                                      null: false
    t.timestamp "date_created",                                      null: false
    t.integer   "user_id"
  end

  add_index "cem_lev", ["contr_rec_id"], name: "fk_cem_lev_contributer_idx", using: :btree
  add_index "cem_lev", ["county_id"], name: "fk_cem_lev_county1_idx", using: :btree
  add_index "cem_lev", ["surveyor_id"], name: "fk_cem_lev_surveyor1_idx", using: :btree
  add_index "cem_lev", ["user_id"], name: "fk_cem_lev_users1_idx", using: :btree

  create_table "class", primary_key: "id_class", force: true do |t|
    t.string  "select",       limit: 10
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "class", ["mon_level_id"], name: "fk_class_mon_level1_idx", using: :btree

  create_table "condition", primary_key: "id_condition", force: true do |t|
    t.string  "select",       limit: 12
    t.integer "mon_level_id",            null: false
  end

  add_index "condition", ["mon_level_id"], name: "fk_condition_mon_level1_idx", using: :btree

  create_table "contributor", primary_key: "id_contr_rec", force: true do |t|
    t.string    "name",         limit: 45
    t.integer   "ex_rec_id"
    t.integer   "contr_id"
    t.timestamp "date_updated",            null: false
    t.timestamp "date_created",            null: false
  end

  create_table "county", primary_key: "id_county", force: true do |t|
    t.string    "name",         limit: 45, null: false
    t.integer   "contr_rec_id"
    t.timestamp "date_updated",            null: false
    t.timestamp "date_created",            null: false
  end

  add_index "county", ["contr_rec_id"], name: "fk_county_contributor1_idx", using: :btree
  add_index "county", ["name"], name: "name_UNIQUE", unique: true, using: :btree

  create_table "databases", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "decay", primary_key: "id_decay", force: true do |t|
    t.string  "select",       limit: 12
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "decay", ["mon_level_id"], name: "fk_decay_mon_level1_idx", using: :btree

  create_table "decay_factors", primary_key: "id_decay_factors", force: true do |t|
    t.string  "select",       limit: 13
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "decay_factors", ["mon_level_id"], name: "fk_decay_factors_mon_level1_idx", using: :btree

  create_table "decor", primary_key: "id_decor", force: true do |t|
    t.string  "type",         limit: 1
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "decor", ["mon_level_id"], name: "fk_decor_mon_level1_idx", using: :btree

  create_table "direction", primary_key: "id_direction", force: true do |t|
    t.string  "select",         limit: 3
    t.string  "dist",           limit: 5
    t.integer "land_feat_id",             null: false
    t.integer "inscription_id",           null: false
  end

  add_index "direction", ["inscription_id"], name: "fk_direction_inscription1_idx", using: :btree
  add_index "direction", ["land_feat_id"], name: "fk_direction_land_feat1_idx", using: :btree

  create_table "enclosed", primary_key: "id_enclosed", force: true do |t|
    t.string  "select",      limit: 10
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "enclosed", ["cem_lev_id"], name: "fk_enclosed_cem_lev1_idx", using: :btree

  create_table "entr_decoration", primary_key: "id_entr_decoration", force: true do |t|
    t.string  "select",      limit: 3
    t.string  "description"
    t.integer "cem_lev_id",            null: false
  end

  add_index "entr_decoration", ["cem_lev_id"], name: "fk_entr_decoration_cem_lev1_idx", using: :btree

  create_table "extra_feat", primary_key: "id_extra_feat", force: true do |t|
    t.string  "select",       limit: 10
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "extra_feat", ["mon_level_id"], name: "fk_extra_feat_mon_level1_idx", using: :btree

  create_table "foundation", primary_key: "id_foundation", force: true do |t|
    t.string  "select",       limit: 8
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "foundation", ["mon_level_id"], name: "fk_foundation_mon_level1_idx", using: :btree

  create_table "grass", primary_key: "id_grass", force: true do |t|
    t.string  "select",       limit: 9
    t.integer "mon_level_id",           null: false
  end

  add_index "grass", ["mon_level_id"], name: "fk_grass_mon_level1_idx", using: :btree

  create_table "head_shape", primary_key: "id_head_shape", force: true do |t|
    t.string  "select",       limit: 14
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "head_shape", ["mon_level_id"], name: "fk_head_shape_mon_level1_idx", using: :btree

  create_table "indiv_lev", primary_key: "id_indiv_lev", force: true do |t|
    t.string    "sex",          limit: 2
    t.string    "first_name",   limit: 45
    t.string    "last_name",    limit: 45
    t.date      "birth_date"
    t.date      "death_date"
    t.string    "occupation",   limit: 45
    t.string    "birth_place",  limit: 45
    t.decimal   "lat",                     precision: 18, scale: 12
    t.decimal   "long",                    precision: 18, scale: 12
    t.string    "approved",     limit: 1
    t.string    "photo_URL"
    t.text      "notes"
    t.integer   "contr_rec_id"
    t.integer   "cem_lev_id"
    t.integer   "county_id"
    t.integer   "surveyor_id"
    t.timestamp "date_updated",                                      null: false
    t.timestamp "date_created",                                      null: false
    t.integer   "mon_level_id"
    t.integer   "user_id"
  end

  add_index "indiv_lev", ["cem_lev_id"], name: "fk_indiv_lev_cem_lev1_idx", using: :btree
  add_index "indiv_lev", ["contr_rec_id"], name: "fk_indiv_lev_contributer1_idx", using: :btree
  add_index "indiv_lev", ["county_id"], name: "fk_indiv_lev_county1_idx", using: :btree
  add_index "indiv_lev", ["mon_level_id"], name: "fk_indiv_lev_mon_level1_idx", using: :btree
  add_index "indiv_lev", ["surveyor_id"], name: "fk_indiv_lev_surveyor1_idx", using: :btree
  add_index "indiv_lev", ["user_id"], name: "fk_indiv_lev_users1_idx", using: :btree

  create_table "insc_tech", primary_key: "id_insc_tech", force: true do |t|
    t.string  "technique",    limit: 9
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "insc_tech", ["mon_level_id"], name: "fk_insc_tech_mon_level1_idx", using: :btree

  create_table "inscription", primary_key: "id_inscription", force: true do |t|
    t.string  "select",       limit: 11
    t.integer "mon_level_id",            null: false
  end

  add_index "inscription", ["mon_level_id"], name: "fk_inscription_mon_level1_idx", using: :btree

  create_table "land_feat", primary_key: "id_land_feat", force: true do |t|
    t.integer "mon_level_id",            null: false
    t.string  "select",       limit: 15, null: false
  end

  add_index "land_feat", ["mon_level_id"], name: "fk_land_feat_mon_level1_idx", using: :btree

  create_table "landscaping", primary_key: "id_landscaping", force: true do |t|
    t.string  "select",      limit: 12
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "landscaping", ["cem_lev_id"], name: "fk_landscaping_cem_lev1_idx", using: :btree

  create_table "lettering", primary_key: "id_lettering", force: true do |t|
    t.string  "material",     limit: 5
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "lettering", ["mon_level_id"], name: "fk_lettering_mon_level1_idx", using: :btree

  create_table "litter", primary_key: "id_litter", force: true do |t|
    t.string  "select",      limit: 11
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "litter", ["cem_lev_id"], name: "fk_litter_cem_lev1_idx", using: :btree

  create_table "location", primary_key: "id_location", force: true do |t|
    t.string  "select",        limit: 6
    t.string  "extent",        limit: 8
    t.string  "direction",     limit: 1
    t.integer "vegetation_id",           null: false
  end

  add_index "location", ["vegetation_id"], name: "fk_location_vegetation1_idx", using: :btree

  create_table "memorial_date", primary_key: "id_memorial_date", force: true do |t|
    t.string  "select",       limit: 18
    t.string  "description"
    t.date    "year"
    t.integer "mon_level_id",            null: false
  end

  add_index "memorial_date", ["mon_level_id"], name: "fk_memorial_date_mon_level1_idx", using: :btree

  create_table "mon_level", primary_key: "id_mon_level", force: true do |t|
    t.string    "exposure",      limit: 23
    t.string    "exp_faces",     limit: 4
    t.string    "face_orient",   limit: 1
    t.string    "material",      limit: 11
    t.string    "num_block",     limit: 4
    t.integer   "dim_height"
    t.integer   "dim_width"
    t.integer   "dim_depth"
    t.text      "insc_transc"
    t.integer   "num_indiv"
    t.integer   "decay"
    t.string    "mem_date",      limit: 45
    t.string    "decay_factors", limit: 45
    t.decimal   "lat",                      precision: 18, scale: 12
    t.decimal   "long",                     precision: 18, scale: 12
    t.string    "approved",      limit: 1
    t.string    "photo_URL",     limit: 45
    t.string    "notes"
    t.integer   "contr_rec_id"
    t.integer   "surveyor_id"
    t.integer   "county_id"
    t.timestamp "date_updated",                                       null: false
    t.timestamp "date_created",                                       null: false
    t.integer   "cem_lev_id"
    t.integer   "user_id"
  end

  add_index "mon_level", ["cem_lev_id"], name: "fk_mon_level_cem_lev1_idx", using: :btree
  add_index "mon_level", ["contr_rec_id"], name: "fk_mon_level_contributer1_idx", using: :btree
  add_index "mon_level", ["county_id"], name: "fk_mon_level_county1_idx", using: :btree
  add_index "mon_level", ["surveyor_id"], name: "fk_mon_level_surveyor1_idx", using: :btree
  add_index "mon_level", ["user_id"], name: "fk_mon_level_users1_idx", using: :btree

  create_table "mortality", primary_key: "id_mortality", force: true do |t|
    t.integer "select"
    t.string  "description"
    t.integer "decor_id",    null: false
  end

  add_index "mortality", ["decor_id"], name: "fk_mortality_decor1_idx", using: :btree

  create_table "movement", primary_key: "id_movement", force: true do |t|
    t.string  "select",       limit: 15
    t.string  "description"
    t.integer "condition_id",            null: false
  end

  add_index "movement", ["condition_id"], name: "fk_movement_condition1_idx", using: :btree

  create_table "other_material", primary_key: "id_other_material", force: true do |t|
    t.string  "type",         limit: 10
    t.string  "description"
    t.integer "mon_level_id",            null: false
  end

  add_index "other_material", ["mon_level_id"], name: "fk_other_material_mon_level1_idx", using: :btree

  create_table "paint", primary_key: "id_paint", force: true do |t|
    t.string  "select",       limit: 7
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "paint", ["mon_level_id"], name: "fk_paint_mon_level1_idx", using: :btree

  create_table "people", primary_key: "id_people", force: true do |t|
    t.string  "select",       limit: 8
    t.integer "mon_level_id",           null: false
  end

  add_index "people", ["mon_level_id"], name: "fk_people_mon_level1_idx", using: :btree

  create_table "relevance", primary_key: "id_relevance", force: true do |t|
    t.string  "select",           limit: 9
    t.string  "description"
    t.integer "decay_factors_id",           null: false
  end

  add_index "relevance", ["decay_factors_id"], name: "fk_relevance_decay_factors1_idx", using: :btree

  create_table "repairs", primary_key: "id_repairs", force: true do |t|
    t.string  "select",       limit: 8
    t.string  "material",     limit: 8
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "repairs", ["mon_level_id"], name: "fk_repairs_mon_level1_idx", using: :btree

  create_table "scratched", primary_key: "id_scratched", force: true do |t|
    t.string  "select",       limit: 3
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "scratched", ["mon_level_id"], name: "fk_scratched_mon_level1_idx", using: :btree

  create_table "site_type", primary_key: "id_site_type", force: true do |t|
    t.string  "select",      limit: 11
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "site_type", ["cem_lev_id"], name: "fk_site_type_cem_lev1_idx", using: :btree

  create_table "situation", primary_key: "id_situation", force: true do |t|
    t.string  "select",      limit: 21
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "situation", ["cem_lev_id"], name: "fk_situation_cem_lev1_idx", using: :btree

  create_table "stone_type", primary_key: "id_stone_type", force: true do |t|
    t.string  "set",          limit: 9
    t.string  "type",         limit: 9
    t.string  "description"
    t.integer "mon_level_id",           null: false
  end

  add_index "stone_type", ["mon_level_id"], name: "fk_stone_type_mon_level1_idx", using: :btree

  create_table "surr_land", primary_key: "id_surr_land", force: true do |t|
    t.string  "select",      limit: 11
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "surr_land", ["cem_lev_id"], name: "fk_surr_land_cem_lev1_idx", using: :btree

  create_table "surveyor", primary_key: "id_surveyor", force: true do |t|
    t.string    "first_name",     limit: 45
    t.string    "last_name",      limit: 45
    t.string    "organization",   limit: 45
    t.date      "date_of_survey"
    t.string    "email",          limit: 45
    t.integer   "res_prox"
    t.string    "cem_assoc",      limit: 45
    t.timestamp "date_updated",              null: false
    t.timestamp "date_created",              null: false
  end

  create_table "trade", primary_key: "id_trade", force: true do |t|
    t.integer "select"
    t.string  "description"
    t.integer "decor_id",    null: false
  end

  add_index "trade", ["decor_id"], name: "fk_trade_decor1_idx", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "vandalism", primary_key: "id_vandalism", force: true do |t|
    t.string  "select",      limit: 11
    t.string  "description"
    t.integer "cem_lev_id",             null: false
  end

  add_index "vandalism", ["cem_lev_id"], name: "fk_vandalism_cem_lev1_idx", using: :btree

  create_table "vegetation", primary_key: "id_vegetation", force: true do |t|
    t.string  "select",       limit: 6
    t.integer "mon_level_id",           null: false
  end

  add_index "vegetation", ["mon_level_id"], name: "fk_vegetation_mon_level1_idx", using: :btree

end
