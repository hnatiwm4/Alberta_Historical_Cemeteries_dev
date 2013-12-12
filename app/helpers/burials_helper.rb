module BurialsHelper

  def photo_link(burial)
    link = ""
    # get external record id from contributor association with
    # burial to create a link to the external url for the photo
    @extern_rec = Contributor.where(:id_contr_rec => burial.contr_rec_id).take
    unless @extern_rec.blank?
      if @extern_rec.contr_id == 9
        link = "http://www.canadianheadstones.com/ab/view.php?id=" + @extern_rec.ex_rec_id.to_s
      else 
        link = burial.photo_URL
      end
    else
      # else return the actual picture link as the photo link
      link = burial.photo_URL
    end

    return link
  end


end
