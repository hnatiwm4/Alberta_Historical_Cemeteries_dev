class MonumentsController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include MonumentsHelper


def search_results
  # NOTE: extra conditionals for pagination, nil on subsequent calls
  if params[:monument]
    if params[:monument].all? {|k,v| v.blank?}
      flash.keep
      flash[:notice] = 'No results Returned for Cemetery Search'
      redirect_to :back and return
      # request.referer + "#monuments/search" and return
    end
  end
  if params[:monument]
    params_rm_blanks(params[:monument])
  end
  eval_date(params,:monument,{m_date: "mem_date"})
  #*** call helper to create query string for basic search
  # NOTE: no options for text fields, all searched by keyword
  query = basic_search(params,params[:monument])
  # find results (use limit and define order from form)
  @monuments = Monument.joins([:burials,:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])
  # ensure result returned, otherwise reload page
  if @monuments.blank?
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
