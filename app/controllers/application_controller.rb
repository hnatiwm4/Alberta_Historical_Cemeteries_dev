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

  # define how to link pictures related to burials based 
  # the inputted contributor id
  def link_photo(contr_id,cid,ppath)
    if contr_id = 9
      # determine photo path from CID
      cpath = "county".sprintf('%03d',cid)
      photo = "http://www.canadianheadstones.com/ab/photos/#{cpath}/#{ppath}"
      return photo
    end
  end




end
