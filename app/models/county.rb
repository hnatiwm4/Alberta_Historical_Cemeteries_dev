# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# COunty model defines the implicit associations with other database elements
#, defines their foreign keys, and corresponding county table
# ##############################################################################

class County < ActiveRecord::Base
  # explicitly set table name for burial records for individual
  self.table_name = "county"
  # each county can have many cemeteries
  has_many :cemeteries, :foreign_key => "county_id"
  
  # specify default ordering when called by relations
  # during search filtering
  default_scope :order => "name ASC"
  
end
