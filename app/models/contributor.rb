# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Contributor model defined to use for associations with Burial model
# (setup as dummy, will need to defined relaitonships later if expanded upon)
# ##############################################################################

class Contributor < ActiveRecord::Base
  # explicitly set table name for contributor table 
  self.table_name = "contributor"
end
