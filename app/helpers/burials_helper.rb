module BurialsHelper

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
