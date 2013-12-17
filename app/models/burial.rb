# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Burial model defines the implicit associations with other database elements
#, defines their foreign keys, and corresponding burial table
# ##############################################################################

class Burial < ActiveRecord::Base
  # explicitly set table name for burial records for individual
  self.table_name = "indiv_lev"

  # each burial belongs to one cemetery
  belongs_to :cemetery, :foreign_key => "cem_lev_id" 
  # each burial belongs to one cemetery
  belongs_to :county, :foreign_key => "county_id" 
  # each burial belongs to one monument 
  belongs_to :monument, :foreign_key => "mon_level_id"
  # define a one-to-one relationship with a contributor record
  has_one :contributor, :foreign_key => "contr_rec_id"

  # method validates data input when submitting a burial record
  validates :last_name, presence: true
  validates :cem_lev_id, presence: true
  validates :county_id, presence: true
end
