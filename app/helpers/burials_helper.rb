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

  # generates a string for date fields withing a table to match
  # (done as date_select returns a hash of values that wont match correctly
  # in where clause)
  # @params: params hash, key string
  # @return: params hash with new key/value for a date 
  def date_string(params,key_str)
    # iterate hash, adding values to array
    values = []
    params.each do |key,value|
      if key.include? key_str
        values.push(value) unless value.blank?
      end
    end
    # add new key/value pair to params
    params[key_str] = values.map {|val| "#{val}"}.join("-")
  end

  


end
