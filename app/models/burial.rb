class Burial < ActiveRecord::Base
  # explicitly set table name for burial records for individual
  self.table_name = "indiv_lev"

  # (correspond foreign key in indiv_lev table to primary specified in code below in all has_one methods to relate correctly)

  # each burial belongs to one cemetery
  belongs_to :cemetery, :foreign_key => "cem_lev_id" 
  # each burial belongs to one cemetery
  belongs_to :county, :foreign_key => "county_id" 
  # each burial will has one monument 
  has_one :monument, :foreign_key => "id_mon_level"
  # define a one-to-one relationship with a contributor record
  has_one :contributor, :foreign_key => "contr_rec_id"

end
