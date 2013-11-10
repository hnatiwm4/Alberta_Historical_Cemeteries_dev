class Cemetery < ActiveRecord::Base
# NOTE: attributes/fields within database table
# can be referenced like instance.cemName,
# in the same way attributes added to a migration
# can be referenced 

  # connect to predefined database
  self.establish_connection(
                            :adapter  => "mysql2",
                            :host     => "localhost",
                            :username => "root",
                            :password => "c3m3t3ry",
                            :database => "canada_headstone_schema"
                            )

  # fix association to use proper foreign key (ie cemetery foreign key in each gravestone row)
  has_many :gravestones, :foreign_key => "cemeteryID"

  # designate which attributes are visible to the model (for inserting using 'create' method)
  # attr_accessor :cemetery

  # method validates data input
  validates :cemName, presence: true,
  length: { minimum: 3 }

end
