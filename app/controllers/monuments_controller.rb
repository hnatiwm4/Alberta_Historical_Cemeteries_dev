# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Monument controller that handles the creation and retrieving of inidividual 
# monument records and their associations to burials, cemeteries, and counties
# ##############################################################################

class MonumentsController < ApplicationController
# include appropriate helpers
include ApplicationHelper
include MonumentsHelper

# unused methods
def new
end

def index
end

# method retrieves and displays a single monument record
def show
  @monument = Monument.find(params[:id])
end

# method handles retreiving monument records and their subsequent
# relations when requested
def search_results
  # produce error and return to referer page if all fields left blank
  if params[:monuments].all? {|k,v| v.blank?}
    flash[:notice] = 'No results Returned for Monument Search'
    redirect_to :back and return
    # request.referer + "#monuments/search" and return
  end
  # call helpers to evalute date and int/enum type returns
  eval_date(params,:monuments,{m_date: "mem_date"})
  eval_int(params[:monuments])
  # remove blanks
  params_rm_blanks(params[:monuments])
  # call helper to create query string for basic search
  query = basic_search(params,params[:monuments])
  # find results (use limit and define order from form)
  @monuments = Monument.joins([:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])
  # ensure result returned, otherwise reload page
  if @monuments.blank?
    flash[:notice] = 'No results Returned for Monument Search'
    redirect_to :back
  else
    # render results list page if limit anything other than 1
    render 'pages/search_results',
    :locals => {:title => "Monument Search Results",
                :table => 'monuments/results_table',
                :params => params[:monuments],
                :object => @monuments }
  end
end

# method retrieves and displays a single monument record
def show
  @monument = Monument.find(params[:id])
end

# use of AJAX to render partial _search view
def search
  respond_to do |format|
    format.js
  end
end


end
