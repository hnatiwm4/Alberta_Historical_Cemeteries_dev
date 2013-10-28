class Gravestone < ActiveRecord::Base
  belongs_to :cemetery
  #expicitly set table name to not plural
  self.table_name = "gravestone"

end
