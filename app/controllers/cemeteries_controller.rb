class CemeteriesController < ApplicationController

# custom action displays the default homepage
def home
  @view = 'home'
  render template: 'cemeteries/template'
end

# action to create new Cemetery object
def new
  # @cemetery = Cemetery.new
end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.order("cemeteries.cemCID ASC").all
  # set view as index
  @view = 'index'
  # render template layout
  render template: 'cemeteries/template'
end

def search
  # set view as index
  @view = 'search'
  # render template layout
  render template: 'cemeteries/template'
end

# action queries the database for results
def create  
  # invokve cemetery instance, retrieve one cemetery name
  @cemeteries = Cemetery.where(params[:cemetery]).take
  
  # ensure result returned, otherwise reload page
  if @cemeteries.blank?
    render '_no_results'
  else
    # redirect to show action
    redirect_to @cemeteries
  end

end

# action displays query results on show page
def show
  # NOTE: calls params[:id] to retrieve query result by id, always do this
  @cemeteries = Cemetery.find(params[:id])
  # set view as show
  @view = 'show'
  # render template layout
  render template: 'cemeteries/template'
end



private
  def cem_params
    params.require(:cemetery).permit(:cemName)
  end


end
