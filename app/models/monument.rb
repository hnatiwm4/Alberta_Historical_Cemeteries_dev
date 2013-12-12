class Monument < ActiveRecord::Base
  # explicitly set table name
  self.table_name = "mon_level"
  
  # each monument may belong to one cemetery
  belongs_to :cemetery, :foreign_key => "cem_lev_id" 
  # each monument may belong to one county
  belongs_to :county, :foreign_key => "county_id" 
  # each monument may have multiple individual burials associated with it
  has_many :burials, :foreign_key => "mon_level_id"

end
