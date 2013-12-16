module ApplicationHelper

  # ========== COMMON HELPERS ==========
  
  # simple helper to test if params value is simply numeric
  # (as all params values return within quotes)
  def is_num?(s)
    Float(s) != nil rescue false
  end
    

  # remove blank values from burial searchs before
  # those values are saved and sent to the Database
  def params_rm_blanks(search)
    search.each do |k,v|
      if v.blank?
        search.delete(k)
      end
    end
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

  # function evalute the imputted array of date fields within params
  # to generate dat_string from the input from the forms
  # (ie creates UNIX datetime formatted field to use for querying)
  # @param: params hash
  # @param: params hash for given object
  # @param: hash of field key/value pairs
  # @return: modified params hash
  def eval_date(params,object,fields)
    fields.each do |key,val|
      if params[key]
        if params[key].to_a
          params[object][val] = date_string(params[key],val)
          params.delete key
        end
      end
    end
  end

  # function evaluate the params hash, determining if any enumerated
  # values exist, if so create special query string for value
  def eval_int(params)
   if params 
     params.each do |key,val|
        if is_num?(val)
          params[key] = val.to_i
        end
     end
   end
  end

  # implements a basic keyword (full text) search using LIKE
  # statements in MySQL (gives full precision of results
  # but at the cost of no recall or fewer relevent results are missing)
  # @param: params hash 
  # @return:query string that will be used in controller

  # NOTE: prvents simple MYSQL Injection by use bind variables
  # and wildcards within an array (not a hardcoded string) 
  def basic_search(params,search)
    arr = []
    temp = []
    if search
      # first iteration, add keys and wildcards
      search.each do |key,val|
        idx = key + "_opt"
        if val.is_a? Integer
           temp.push("#{key}=?") unless val.blank?
        elsif params[idx]
          if params[idx] == "keyword"
            temp.push("#{key} LIKE (?)") unless val.blank?
          elsif params[idx] == "starts"
            temp.push("#{key} LIKE (?)") unless val.blank?
          elsif params[idx] == "ends"
            temp.push("#{key} LIKE (?)") unless val.blank?
          elsif params[idx] == "exact"
            temp.push("#{key}=?") unless val.blank?
          end
        else
          temp.push("#{key} LIKE (?)") unless val.blank?
        end
      end
      # convert temp array to string, join with ANDs, add to arr
      arr.push(temp.map {|t| "#{t}"}.join(" AND "))
      # second iteration, add values for corresponding wildcards
      search.each do |key,val|
        idx = key + "_opt"
        if val.is_a? Integer
           arr.push(search[key]) unless val.blank?
        elsif params[idx]
          if params[idx] == "keyword"
            arr.push("%#{val}%") unless val.blank?
          elsif params[idx] == "starts"
            arr.push("#{val}%") unless val.blank?
          elsif params[idx] == "ends"
            arr.push("%#{val}") unless val.blank?
          elsif params[idx] == "exact"
            arr.push("\"#{val}\"") unless val.blank?
          end
        else
          arr.push("%#{val}%") unless val.blank?
        end
      end
    # else if search doesnt exist, return nothing
    else  
      return
    end
    # return bind variable array for use in where clause
    return arr
  end




  def get_contr_from_id(object)
    return Contributor.where(:id_contr_rec => object.contr_rec_id).take
  end




  def photo_link(object)
    # get external record id from contributor association with
    # to create a link to the external url for the photo
    @extern_rec = get_contr_from_id(object)
    unless @extern_rec.blank?
      if @extern_rec.contr_id == 9
        return "http://www.canadianheadstones.com/ab/view.php?id=" + @extern_rec.ex_rec_id.to_s
      else 
        return object.photo_URL
      end
    else
      # else return nil
      return nil
    end
    return nil
  end




end
