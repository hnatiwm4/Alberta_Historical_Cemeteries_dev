# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Burial controller that handles the creation and retrieving of inidividual 
# burial records
# ##############################################################################

class BurialsController < ApplicationController
# include appropriate helpers
include ApplicationHelper
include BurialsHelper

# index unused, will need to define if used in future
def index
end

# This method creates a burial through the submit form page
def create
  @burial = Burial.new(bur_params)
  if @burial.save
    redirect_to @burial
  else
    flash[:notice] = 'Incorrect Cemetery Records or fields left blank'
    redirect_to :back
  end
end

# This method parses params, generates queries to return burial 
# and associated records from searchs
def search_results
  # return error to referrer page if al fields left blank
  if params[:burials].all? {|k,v| v.blank?}
    flash[:notice] = 'No results Returned for Buial Search'
    redirect_to :back and return 
    # request.referer + "#burials/search" and return
  end
  # call helper function to evaluate int/enum fields
  eval_date(params,:burials,{b_date: "birth_date",d_date: "death_date"})
  # call helper to remove any blank values
  params_rm_blanks(params[:burials])
  # call helper to create query string for basic search
  query = basic_search(params,params[:burials])
  # find results (use limit and define order from form)
  @burials = Burial.joins([:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])
  # ensure result returned, otherwise reload page
  if @burials.blank?
    flash[:notice] = 'No results Returned for Buial Search'
    redirect_to :back
  else
    # render results list page if limit anything other than 1
    render 'pages/search_results',
    :locals => {:title => "Burial Search Results",
                :table => 'burials/results_table',
                :params => params[:burials],
                :object => @burials}
  end
end

# method displays query result on show page for a single burial
def show
  @burial = Burial.find(params[:id])
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


# private parameters defined for creating new burial records (ie what is required)
private

  def bur_params
    allow = [:last_name,:first_name,:cem_lev_id,:county_id,:user_id]
    params.require(:burial).permit(allow)
  end


end
