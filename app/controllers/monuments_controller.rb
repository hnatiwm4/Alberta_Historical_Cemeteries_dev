class MonumentsController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include MonumentsHelper

def show
  @monument = Monument.find(params[:id])
end

def search_results
  if params[:monument].all? {|k,v| v.blank?}
    flash[:notice] = 'No results Returned for Monument Search'
    redirect_to :back and return
    # request.referer + "#monuments/search" and return
  end
  # call helpers to evalute date and int/enum type returns
  eval_date(params,:monument,{m_date: "mem_date"})
  eval_int(params[:monument])
  # remove blanks
  params_rm_blanks(params[:monument])
  # call helper to create query string for basic search
  # NOTE: removed burials join, not needed in query
  query = basic_search(params,params[:monument])
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
