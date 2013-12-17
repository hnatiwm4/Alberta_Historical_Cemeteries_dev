# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Cemetery model defines the implicit associations with other database elements
#, defines their foreign keys, and corresponding cemetery table
# ##############################################################################

class Cemetery < ActiveRecord::Base
  # explicitly set table name for cemeteries
  self.table_name = "cem_lev"

  # each cemetery belongs to one cemetery
  belongs_to :county, :foreign_key => "county_id"
  # each cemetery encompasses many monuments
  has_many :monuments, :foreign_key => "cem_lev_id"
  # each cemetery encompasses many burial sites
  has_many :burials, :foreign_key => "cem_lev_id"

  # specify default ordering when called by relations
  # during search filtering
  default_scope :order => "cem_name ASC"

  # method validates data input when submitting a cemetery record
  validates :county_id, presence: true
  validates :cem_name, presence: true
end
