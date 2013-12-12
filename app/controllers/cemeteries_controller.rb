class CemeteriesController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include CemeteriesHelper

# action to create new Cemetery object
#def new
#  @cemeteries = Cemetery.new
#end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.order("id_cem_lev ASC").all
end

# acquire param values from submit action, insert into outside sql database
def create
  @cemeteries = Cemetery.create(cem_params)
  if @cemeteries.save
    redirect_to @cemeteries
  else
    # redirect back to submit page
    render 'submit'
  end

end

# action queries the database for results
def search_results
  # call helper to remove blank fields from param
  params_rm_blanks(params[:cemetery]);
  # call helper to create query string for basic search
  query = basic_search(params,params[:cemetery])
  # invokve cemetery instance, retrieve one cemetery name
  # @cemeteries = Cemetery.find(:all, conditions: query, limit: params[:limit] \
  #                           , order: params[:order], joins: [:county])
  @cemeteries = Cemetery.joins(:county).where(query).limit(params[:limit]).order(params[:order])

  # ensure result returned, otherwise reload page
  if @cemeteries.blank?
    render 'pages/_no_results'
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
  # NOTE: calls params[:id] to retrieve query result by id, always do this
  @cemeteries = Cemetery.find(params[:id])
  # create flash message with appropreiate message if cemetery
  # record does not contain lat or longitudinal information
  if @cemeteries.lat == 0.0 && @cemeteries.long == 0.0
    flash.now[:notice] = 'Information for Map Unavailable'
  end
  # @cid = Database.connection.select(
  #      "SELECT CT_PhotoPath FROM countylist 
  #      WHERE CountyID=#{@cemeteries.cemCID}").first
  # render template layout (view is show)
  #render template: 'cemeteries/template',
   #      :locals => {:view => 'show'}
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
    allow = [:cem_name]
    params.require(:cemetery).permit(allow)
  end


end
