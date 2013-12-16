# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Cemetery controller that handles the creation and retrieving of inidividual 
# cemetery records and their associations to burials and counties
# ##############################################################################

class CemeteriesController < ApplicationController
# include appropriate helpers
include ApplicationHelper
include CemeteriesHelper

# method instantiates a new instance object for a cemetery record
def new
  @cemeteries = Cemetery.new
end

# method displays all cemetery records
def index
  @cemeteries = Cemetery.joins(:county).paginate(page: params[:page])
end

# method creates a new record from the inputted fields on the submit form
def create
  @cemetery = Cemetery.new(cem_params)
  if @cemetery.save
    redirect_to @cemetery
  else
    flash[:notice] = 'Incorrect Cemetery Records or fields left blank'
    redirect_to :back
  end
end

# method handles the retreiving of cemetery records and their subsequent
# relations when requested
def search_results
  # produce error and return to referer page if all fields left blank
  if params[:cemetery].all? {|k,v| v.blank?}
    flash[:notice] = 'No results Returned for Cemetery Search'
    redirect_to :back and return
  end
  # call hellper function to remove blanks fields
  params_rm_blanks(params[:cemetery])
  # call helper to create query string for basic search
  query = basic_search(params,params[:cemetery])
  # invoke cemetery instance, retrieve one cemetery name
  @cemeteries = Cemetery.joins(:county).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])
  # ensure result returned, otherwise reload page
  if @cemeteries.blank?
    flash[:notice] = 'No results Returned for Cemetery Search'
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

#  method displays query results 
def show
  @cemetery = Cemetery.find(params[:id])
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

# private parameters defined for creating new cemetery records (ie what is required)
private

  def cem_params
    allow = [:cem_name,:user_id,:county_id]
    params.require(:cemetery).permit(allow)
  end


end
