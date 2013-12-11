class Burial < ActiveRecord::Base
  # explicitly set table name for burial records for individual
  self.table_name = "indiv_lev"
  # each burial will belong to a cemetery
  belongs_to :cemetery  
  # each burial will belong to a county
  belongs_to :county  
  # each burial will belong to a monument
  belongs_to :monument
  
  has_one :contributor

end
