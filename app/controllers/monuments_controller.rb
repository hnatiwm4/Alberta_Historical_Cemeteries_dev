class MonumentsController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include MonumentsHelper


def search_results
  # call helper function to remove blanks from param
  params_rm_blanks(params[:monument])
  # call helper to check for any numeric or enum values, convert to integer
  eval_int(params[:monument])
  # convert date hash values to strings to use in WHERE clause
  if params[:m_date].to_a 
    params[:monument][:mem_date] = date_string(params[:m_date],"mem_date")
    params.delete :m_date
  end

  #*** call helper to create query string for basic search
  # NOTE: no options for text fields, all searched by keyword
  query = basic_search(params,params[:monument])

  # find results (use limit and define order from form)
  # @monuments = Monument.find(:all, conditions: query, limit: params[:limit] \
  #                           , order: params[:order], joins: [:burials,:cemetery,:county])
  @monuments = Monument.joins([:burials,:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order])
  
  # ensure result returned, otherwise reload page
  if @monuments.blank?
    render 'pages/_no_results'
  else
    # render results list page if limit anything other than 1
    render 'pages/search_results',
    :locals => {:title => "Monument Search Results",
                :table => 'monuments/results_table',
                :params => params[:monument],
                :object => @monuments }
  end


end

# use of AJAX to render partial _search view
def search
  respond_to do |format|
    format.js
  end
end



end
