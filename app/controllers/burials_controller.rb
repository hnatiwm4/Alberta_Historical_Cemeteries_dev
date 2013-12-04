class BurialsController < ApplicationController

def index
end

def search_results
  # call helper function to remove blanks from burial param
  query = params_rm_blanks(params[:burial]);
  # find results (use limit and define order from form)
  @burials = Burial.where(query).limit(params[:limit]).order(params[:order])
  # ensure result returned, otherwise reload page
  if @burials.blank?
    render 'pages/_no_results'
  elsif params[:limit].to_i > 1
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

# action displays query result on show page for a single burial
def show
  # for testing
  # county026
  # c026_wiebe_j_id24685.jpg
  @burials = Burial.find(params[:id])
end


# use of AJAX to render partial _search view
def search
  respond_to do |format|
    format.js
  end
end

# use of AJAX to render partial _submit view
def submit
  respond_to do |format|
    format.js
  end
end


end
