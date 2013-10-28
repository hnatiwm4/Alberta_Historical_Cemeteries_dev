class CemeteriesController < ApplicationController

# custom action displays the default homepage
def home
  # render template layout (view is home) 
  render template: 'cemeteries/template',
         :locals => {:view => 'home' }
end

# action to create new Cemetery object
def new
  # @cemetery = Cemetery.new
end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.order("cemeteries.cemCID ASC").all
  # render template layout (view is index)
  render template: 'cemeteries/template', 
         :locals => {:view => 'index' } 
end

def search
  # render template layout (view is search)
  render template: 'cemeteries/template', 
         :locals => {:view => 'search' } 
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
  @cid = Database.connection.select(
        "SELECT CT_PhotoPath FROM countylist 
        WHERE CountyID=#{@cemeteries.cemCID}").first;
  # render template layout (view is show)
  render template: 'cemeteries/template', 
         :locals => {:view =>'show'} 
end



private
  def cem_params
    params.require(:cemetery).permit(:cemName)
  end


end
