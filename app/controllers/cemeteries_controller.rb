class CemeteriesController < ApplicationController

# custom action displays the default homepage
def home
  # render template layout (view is home) 
  render template: 'cemeteries/template',
         :locals => {:view => 'home' }
end

# action to create new Cemetery object
# NOTE: sent here if cem_params not met in create method
#def new
#  @cemeteries = Cemetery.new
#end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.order("id_cem_lev ASC").all
  # render template layout (view is index)
  render template: 'cemeteries/template', 
         :locals => {:view => 'index' }
end

# render submit page to submit cemetery data (on submit, redirects to create action)
def submit
  render template: 'cemeteries/template', 
           :locals => {:view => 'submit' }
end

# acquire param values from submit action, insert into outside sql database
def create
  @cemeteries = Cemetery.create(cem_params)
  if @cemeteries.save
    redirect_to @cemeteries
  else
    # redirect back to submit page
    redner 'submit'
  end

end

def search
  # render template layout (view is search)
  render template: 'cemeteries/template', 
         :locals => {:view => 'search' } 
end

# action queries the database for results
def search_results
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
  # @cid = Database.connection.select(
  #      "SELECT CT_PhotoPath FROM countylist 
  #      WHERE CountyID=#{@cemeteries.cemCID}").first
  # render template layout (view is show)
  render template: 'cemeteries/template',
         :locals => {:view => 'show'}
end



private
  def cem_params
    allow = [:cem_name]
    params.require(:cemetery).permit(allow)
  end


end
