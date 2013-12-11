module ApplicationHelper

  # ========== COMMON HELPERS ==========

  # remove blank values from burial searchs before
  # those values are saved and sent to the Database
  def self.params_rm_blanks(search)
    search.each do |k,v|
      if v.blank?
        search.delete(k)
      end
    end
  end

  # implements a basic keyword (full text) search using LIKE
  # statements in MySQL (gives full precision of results
  # but at the cost of no recall or fewer relevent results are missing)
  # @param: params hash 
  # @return:query string that will be used in controller

  # NOTE: inefficient for large databases (linear search)
  def self.basic_search(params,search)
    str_arr = []

    if search
      search.each do |key,val|
        idx = key + "_opt"
        if params[idx]
          if params[idx] == "keyword"
            str_arr.push("#{key} LIKE '%#{val}%'") unless val.blank?
          elsif params[idx] == "starts"
            str_arr.push("#{key} LIKE '#{val}%'") unless val.blank?
          elsif params[idx] == "ends"
            str_arr.push("#{key} LIKE '%#{val}'") unless val.blank?
          elsif params[idx] == "exact"
            str_arr.push("#{key}=\"#{val}\"") unless val.blank?
          end
        else
          # else, for field search by keyword
          str_arr.push("#{key} LIKE '%#{val}%'") unless val.blank?
        end
      end
    # else if search doesnt exist, return nothing
    else  
      return
    end
    # return array to string, joined by AND's
    return str_arr.map {|str| "#{str}"}.join(" AND ")

  end

end
