class CemeteriesController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include CemeteriesHelper

def new
  @cemeteries = Cemetery.new
end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.order("id_cem_lev ASC").all
end

def create
  @cemeteries = Cemetery.new(cem_params)
  if @cemeteries.save
    redirect_to @cemeteries
  else
    render 'cemeteries/submit'
  end
end

# action queries the database for results
def search_results
  # NOTE: extra conditional for pagination, nil on subsequent calls
  if params[:cemetery]
    if params[:cemetery].all? {|k,v| v.blank?}
      flash[:notice] = 'No results Returned for Cemetery Search'
      redirect_to :back and return
    end
  end
  # (conditional for pagination, params[:burial] nil on subsequent calls to method
  if params[:cemetery]
    params_rm_blanks(params[:cemetery])
  end
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
  @cemeteries = Cemetery.find(params[:id])
  # create flash message with appropreiate message if cemetery
  # record does not contain lat or longitudinal information
  if @cemeteries.lat == 0.0 && @cemeteries.long == 0.0
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
