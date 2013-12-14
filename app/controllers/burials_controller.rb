class BurialsController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include BurialsHelper

def index
end

def search_results  
  # call helper function to remove blanks from param
  params_rm_blanks(params[:burial]);
  # convert date hash values to strings to use in WHERE clause
  eval_date(params,:burial,{b_date: "birth_date",d_date: "death_date"})

  #*** call helper to create query string for basic search
  query = basic_search(params,params[:burial])

  # find results (use limit and define order from form)
  @burials = Burial.joins([:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])

  # ensure result returned, otherwise reload page
  if @burials.blank?
    render 'pages/_no_results'
  else
    # render results list page if limit anything other than 1
    render 'pages/search_results',
    :locals => {:title => "Burial Search Results",
                :table => 'burials/results_table',
                :params => params[:burial],
                :object => @burials }
  end


end

# action displays query result on show page for a single burial
def show
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
