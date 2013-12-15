class CemeteriesController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include CemeteriesHelper

def new
  @cemeteries = Cemetery.new
end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.joins(:county).paginate(page: params[:page])
end

def create
  @cemetery = Cemetery.new(cem_params)
  if @cemetery.save
    redirect_to @cemetery
  else
    flash[:notice] = 'Incorrect Cemetery Records or fields left blank'
    redirect_to :back
  end
end

# action queries the database for results
def search_results
  if params[:cemetery].all? {|k,v| v.blank?}
    flash[:notice] = 'No results Returned for Cemetery Search'
    redirect_to :back and return
  end
  params_rm_blanks(params[:cemetery])
  #*** call helper to create query string for basic search
  query = basic_search(params,params[:cemetery])
  # invokve cemetery instance, retrieve one cemetery name
  @cemeteries = Cemetery.joins(:county).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])
  # ensure result returned, otherwise reload page
  if @cemeteries.blank?
    redirect_to :back
  else
    # else return results page
    render 'pages/search_results',
    :locals => {:title => "Cemetery Search Results",
                :table => 'cemeteries/results_table',
                :params => params[:cemetery],
                :object => @cemeteries }
  end
end

# action displays query results on show page
def show
  @cemetery = Cemetery.find(params[:id])
  # create flash message with appropreiate message if cemetery
  # record does not contain lat or longitudinal information
  if @cemetery.lat == 0.0 && @cemetery.long == 0.0
    flash.now[:notice] = 'Information for Map Unavailable'
  end
end

# use of AJAX to render partial _search view
def search
  respond_to do |format|
    format.js
  end
end

# use of AJAX to redner partial _submit view
def submit
  respond_to do |format|
    format.js
  end
end


private

  def cem_params
    allow = [:cem_name,:user_id,:county_id]
    params.require(:cemetery).permit(allow)
  end


end
