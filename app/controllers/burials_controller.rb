class BurialsController < ApplicationController
# include appropreiate helper
include BurialsHelper

def index
end

def search_results
  # call helper function to remove blanks from param
  ApplicationHelper.params_rm_blanks(params[:burial]);
  # convert birth_date and death_date hash values to strings to use in WHERE clause if values not empty
  # NOTE: hash key b_date and d_date hardcoded in controller and view
  if params[:b_date].to_a 
    params[:burial][:birth_date] = date_string(params[:b_date],"birth_date")
    params.delete :b_date
    params[:burial].delete(:birth_date)
  end
  if params[:d_date].to_a
    params[:burial][:death_date] = date_string(params[:d_date],"death_date")
    params.delete :d_date
    params[:burial].delete(:death_date)
  end
  # call helper to create query string for basic search
  query = ApplicationHelper.basic_search(params[:burial],params[:search_opt])
  # find results (use limit and define order from form)
  @burials = Burial.find(:all, :conditions => query, :limit => params[:limit], :order => params[:order])
  # ensure result returned, otherwise reload page
  if @burials.blank?
    render 'pages/_no_results'
  elsif params[:limit].to_i > 1
    # render results list page if limit anything other than 1
    render 'pages/search_results',
    :locals => {:title => "Burial Search Results",
                :table => 'burials/results_table',
                :params => params[:burial],
                :object => @burials}
  else
    # redirect to show action (single result)
    redirect_to @burials
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
