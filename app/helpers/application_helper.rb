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
  def self.basic_search(search,option)
    str = ""
    if search
      if option == "keyword"
        str = (search.map { |k,v| "#{k} LIKE '%#{v}%'" }).join(" AND ")
      elsif option == "exact"
        str = (search.map { |k,v| "#{k}=\"#{v}\"" }).join(" AND ")
      end
    end
    return str
  end

end
