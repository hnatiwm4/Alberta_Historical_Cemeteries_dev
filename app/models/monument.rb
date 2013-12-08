class Monument < ActiveRecord::Base
  # explicitly set table name
  self.table_name = "mon_level"
  # each monument may have multiple individual burials associated with it
  has_many :burials, :foreign_key => "mon_level_id"

end
