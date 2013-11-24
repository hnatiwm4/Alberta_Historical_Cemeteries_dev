class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # CUSTOM HELPERS
  
  # remove blank values from burial searchs before
  # those values are saved and sent to the Database
  def param_rm_blanks(search)
    search.each do |k,v|
      if v.blank?
        search.delete(k)
      end
    end
  end


end
