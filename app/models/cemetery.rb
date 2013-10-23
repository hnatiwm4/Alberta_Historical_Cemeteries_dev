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

# method validates data
  validates :cemName, presence: true

end
