class Burial < ActiveRecord::Base
  belongs_to :cemetery
  # explicitly set table name for burial records for individual
  self.table_name = "indiv_lev"

end
