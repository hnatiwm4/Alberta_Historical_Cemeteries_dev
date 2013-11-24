class BurialsController < ApplicationController

def index
end

def search
  # remove blank fields before search
  q = param_rm_blanks(params[:burial])
  # get count of number of objects to be returned)
  c = Burial.where(q).count
  # copy count for use in where where() method
  l = c
  # find all results
  @burials = Burial.where(q).limit(l)
  # ensure result returned, otherwise reload page
  if @burials.blank?
    render 'pages/_no_results'
  elsif c > 1
    # render results list page
    render 'burials/search_results'
  else
    # redirect to show action (single result)
    # NOTE: since abouve where() creates a relation and
    # not a single records, for single record cases just use
    # the .first method to retrieve it correctly
    redirect_to @burials.first
  end

end

# action displays a list of query results 
def search_results
end

# action displays query result on show page for a single burial
def show
  @burials = Burial.find(params[:id])
end


end
