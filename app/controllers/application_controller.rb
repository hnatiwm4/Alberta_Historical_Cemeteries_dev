# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Applications controller handles common methods and definitions
# ##############################################################################

class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  include SessionsHelper

end
