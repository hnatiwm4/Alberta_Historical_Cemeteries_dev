class Burial < ActiveRecord::Base
  # explicitly set table name for burial records for individual
  self.table_name = "indiv_lev"
  # each burial will belong to a cemetery
  belongs_to :cemetery  

end
