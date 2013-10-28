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

ActiveRecord::Schema.define(version: 20131026193239) do

  create_table "AncestryStatus", id: false, force: true do |t|
    t.string   "Trans",   limit: 1, default: "", null: false
    t.integer  "id",                default: 0,  null: false
    t.datetime "Updated",                        null: false
  end

  add_index "AncestryStatus", ["id"], name: "id", using: :btree

  create_table "AncestryTrans", id: false, force: true do |t|
    t.string   "Trans",    limit: 1,  default: "", null: false
    t.integer  "id",                  default: 0,  null: false
    t.string   "Given",    limit: 60
    t.string   "Surname",  limit: 30
    t.string   "Cemetery", limit: 75
    t.string   "County",   limit: 40
    t.text     "Notes"
    t.datetime "Updated",                          null: false
  end

  add_index "AncestryTrans", ["id"], name: "id", using: :btree

  create_table "AncestryView", id: false, force: true do |t|
    t.string   "Trans",    limit: 1,  default: ""
    t.integer  "id",                  default: 0,  null: false
    t.string   "Given",    limit: 60
    t.string   "Surname",  limit: 30
    t.string   "Cemetery", limit: 75
    t.string   "County",   limit: 40, default: ""
    t.text     "Notes"
    t.datetime "Updated",                          null: false
    t.datetime "Last"
  end

  create_table "cemeteries", primary_key: "cemID", force: true do |t|
    t.integer   "cemCID",                   default: 0,   null: false
    t.string    "cemApproved",   limit: 1,  default: "N", null: false
    t.string    "cemName",       limit: 75, default: "",  null: false
    t.string    "cemTownship",   limit: 60, default: "",  null: false
    t.text      "cemDirections",                          null: false
    t.string    "cemPhotoURL",   limit: 60, default: "",  null: false
    t.timestamp "cemUpdated",                             null: false
  end

  create_table "countyaccess", primary_key: "ca_id", force: true do |t|
    t.integer "ca_uid",              default: 0, null: false
    t.integer "ca_cid",              default: 0, null: false
    t.integer "ca_access", limit: 2, default: 0, null: false
  end

  create_table "countylist", primary_key: "CountyID", force: true do |t|
    t.string   "CT_Name",          limit: 40,  default: "", null: false
    t.string   "CT_HomePage",      limit: 100
    t.string   "CT_PhotoPath",     limit: 75
    t.string   "CT_SubmitAddr",    limit: 50
    t.string   "CT_ContactAddr",   limit: 50
    t.integer  "CT_CoordinatorID",             default: 0,  null: false
    t.integer  "CT_QtyApproved",               default: 0,  null: false
    t.integer  "CT_QtyUnapproved",             default: 0,  null: false
    t.integer  "CT_QtyTrash",                  default: 0,  null: false
    t.integer  "CT_QtyTotal",                  default: 0,  null: false
    t.integer  "CT_QtyPhotos",                 default: 0,  null: false
    t.integer  "CT_DiskSpace",                 default: 0,  null: false
    t.datetime "CT_LastUpdated",                            null: false
    t.string   "CT_Flag",          limit: 1,   default: "", null: false
  end

  add_index "countylist", ["CountyID"], name: "CountyID", using: :btree

  create_table "databases", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gravestone", primary_key: "entryid", force: true do |t|
    t.integer  "groupid",                   default: 0,   null: false
    t.integer  "CID",                       default: 0,   null: false
    t.string   "last",          limit: 30
    t.string   "first",         limit: 60
    t.string   "cemetery",      limit: 75
    t.integer  "cemeteryID",                default: 0,   null: false
    t.string   "photoURL",      limit: 150
    t.integer  "filesize",      limit: 3,   default: 0,   null: false
    t.integer  "width",         limit: 2,   default: 0,   null: false
    t.integer  "height",        limit: 2,   default: 0,   null: false
    t.text     "comments"
    t.string   "email_address", limit: 55
    t.string   "hide_email",    limit: 1,   default: "N", null: false
    t.string   "approved",      limit: 1,   default: "N", null: false
    t.string   "tempfile",      limit: 50,  default: "",  null: false
    t.integer  "viewcount",                 default: 0,   null: false
    t.datetime "lastview",                                null: false
    t.datetime "dt_submit",                               null: false
    t.datetime "dt_active",                               null: false
    t.datetime "dt_updated",                              null: false
    t.integer  "archived",      limit: 1,   default: 0,   null: false
  end

  add_index "gravestone", ["CID"], name: "CID", using: :btree
  add_index "gravestone", ["approved"], name: "approved", using: :btree
  add_index "gravestone", ["cemeteryID"], name: "cemeteryID", using: :btree
  add_index "gravestone", ["dt_submit"], name: "DT_Submit", using: :btree
  add_index "gravestone", ["groupid"], name: "groupid", using: :btree
  add_index "gravestone", ["photoURL"], name: "photoURL", using: :btree

  create_table "htmltext", primary_key: "htmID", force: true do |t|
    t.string   "htmCat",       limit: 30, default: "",  null: false
    t.string   "htmSect",      limit: 30, default: "",  null: false
    t.text     "htmText"
    t.datetime "htmCreated",                            null: false
    t.datetime "htmUpdated",                            null: false
    t.string   "htmUpdatedBy", limit: 25, default: "",  null: false
    t.string   "htmStatus",    limit: 1,  default: "0", null: false
  end

  add_index "htmltext", ["htmCat", "htmSect"], name: "Key", unique: true, length: {"htmCat"=>6, "htmSect"=>6}, using: :btree

  create_table "notice", force: true do |t|
    t.string   "name",      limit: 100, default: "", null: false
    t.text     "notes",                              null: false
    t.string   "status",    limit: 3,   default: "", null: false
    t.datetime "submitted",                          null: false
    t.date     "send",                               null: false
    t.datetime "sent",                               null: false
  end

  create_table "online", primary_key: "idx", force: true do |t|
    t.string   "hash",    limit: 50, default: "", null: false
    t.string   "page",    limit: 50, default: "", null: false
    t.datetime "thetime",                         null: false
  end

  create_table "postings", primary_key: "pID", force: true do |t|
    t.integer  "pGraveID",              default: 0,  null: false
    t.string   "pName",     limit: 60,  default: "", null: false
    t.string   "pEmail",    limit: 60,  default: "", null: false
    t.string   "pURL",      limit: 100, default: "", null: false
    t.string   "pURLTitle", limit: 100, default: "", null: false
    t.string   "pNote",                 default: "", null: false
    t.string   "pPasswd",   limit: 50,  default: "", null: false
    t.datetime "pCreated",                           null: false
    t.datetime "pUpdated",                           null: false
  end

  add_index "postings", ["pGraveID"], name: "pGraveID", using: :btree

  create_table "prefs", primary_key: "prefID", force: true do |t|
    t.string    "prefKey",     limit: 25, default: "", null: false
    t.string    "prefValue",              default: "", null: false
    t.timestamp "prefUpdated",                         null: false
  end

  add_index "prefs", ["prefKey"], name: "prefKey", using: :btree

  create_table "todo", force: true do |t|
    t.string   "name",      limit: 100, default: "", null: false
    t.text     "notes",                              null: false
    t.string   "status",    limit: 3,   default: "", null: false
    t.datetime "submitted",                          null: false
  end

  create_table "users", primary_key: "u_ID", force: true do |t|
    t.string   "u_Name",      limit: 25, default: "",  null: false
    t.string   "u_Login",     limit: 15, default: "",  null: false
    t.string   "u_Pwd",       limit: 40, default: "",  null: false
    t.binary   "u_Passwd",                             null: false
    t.integer  "u_County",               default: 0,   null: false
    t.string   "u_Email",     limit: 50, default: "",  null: false
    t.string   "u_Street",    limit: 50, default: "",  null: false
    t.string   "u_CSZ",       limit: 50, default: "",  null: false
    t.string   "u_Phone",     limit: 50, default: "",  null: false
    t.string   "u_Title",     limit: 40, default: "",  null: false
    t.integer  "u_Access",               default: 0,   null: false
    t.datetime "u_Created",                            null: false
    t.datetime "u_Updated",                            null: false
    t.string   "u_Status",    limit: 1,  default: "",  null: false
    t.string   "u_Type",      limit: 1,  default: "R", null: false
    t.integer  "u_LastNews",             default: 0,   null: false
    t.datetime "u_LastLogin",                          null: false
  end

  add_index "users", ["u_County"], name: "u_County", using: :btree
  add_index "users", ["u_ID"], name: "u_ID", using: :btree
  add_index "users", ["u_Login"], name: "u_Login", using: :btree

end
