class BurialsController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include BurialsHelper

# index action displays all burial records
def index
  # @burials = Burial.order("id_ ASC").all
end

def search_results
  # call helper function to remove blanks from param
  params_rm_blanks(params[:burial]);
  # convert date hash values to strings to use in WHERE clause
  if params[:b_date].to_a 
    params[:burial][:birth_date] = date_string(params[:b_date],"birth_date")
    params.delete :b_date
  end
  if params[:d_date].to_a
    params[:burial][:death_date] = date_string(params[:d_date],"death_date")
    params.delete :d_date
  end

  #*** call helper to create query string for basic search
  query = basic_search(params,params[:burial])

  # find results (use limit and define order from form)
  # @burials = Burial.find(:all, conditions: query, limit: params[:limit] \
  #                       , order: params[:order], joins: [:cemetery,:county])
  @burials = Burial.joins([:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order])

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
