class Cemetery < ActiveRecord::Base
# NOTE: attributes/fields within database table
# can be referenced like instance.cemName,
# in the same way attributes added to a migration
# can be referenced 

  # IMPORTANT: expicitly set table name
  self.table_name = "cem_lev"

  belongs_to :county
  has_many :burials, :foreign_key => "cem_lev_id"
  


  # designate which attributes are visible to the model (for inserting using 'create' method)
  #attr_accessor :cemetery

  # method validates data input
  # validates :cemName, presence: true,
  # length: { minimum: 3 }
end
