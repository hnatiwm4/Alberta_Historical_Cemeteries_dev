class County < ActiveRecord::Base
  # explicitly set table name for burial records for individual
  self.table_name = "county"
  # each county can have many cemeteries
  has_many :cemeteries, :foreign_key => "county_id"
  
end
