class BurialsController < ApplicationController
# include appropreiate helpers
include ApplicationHelper
include BurialsHelper

def index
end


def create
  @burial = Burial.new(bur_params)
  if @burial.save
    redirect_to @burial
  else
    flash[:notice] = 'Incorrect Cemetery Records or fields left blank'
    redirect_to :back
  end
end


def search_results  
  # NOTE: extra conditionals for pagination, nil on subsequent calls
  if params[:burial]
    if params[:burial].all? {|k,v| v.blank?}
      flash[:notice] = 'No results Returned for Cemetery Search'
      redirect_to :back and return 
      # request.referer + "#burials/search" and return
    end
  end
  if params[:cemetery]
    params_rm_blanks(params[:cemetery])
  end
  eval_date(params,:burial,{b_date: "birth_date",d_date: "death_date"})
  #*** call helper to create query string for basic search
  query = basic_search(params,params[:burial])
  # find results (use limit and define order from form)
  @burials = Burial.joins([:cemetery,:county]).where(query).limit(params[:limit]).order(params[:order]).paginate(page: params[:page])
  # ensure result returned, otherwise reload page
  if @burials.blank?
    redirect_to :back
  else
    # render results list page if limit anything other than 1
    render 'pages/search_results',
    :locals => {:title => "Burial Search Results",
                :table => 'burials/results_table',
                :params => params[:burial],
                :object => @burials}
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



private

  def bur_params
    allow = [:last_name,:first_name,:user_id]
    params.require(:burial).permit(allow)
  end


end
