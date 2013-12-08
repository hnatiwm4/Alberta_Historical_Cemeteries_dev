module BurialsHelper

  # define how to link photo_URLs related to burials based 
  # the inputted contributor id
  # @param: burials contributor id
  # @return: page string
  def link_photo_page(burial)
    page = ""
    if burial.contr_rec_id = 9
      url = "http://www.canadianheadstones.com/ab/"
      # use regex to parse out ending from url used as
      # if to link to page
      photo = burial.photo_URL
      photo.gsub(/_[^_]*$/)
      page = url + "view.php?id=" + photo
    end
    return photo
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
