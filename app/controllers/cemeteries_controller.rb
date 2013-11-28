class CemeteriesController < ApplicationController

# action to create new Cemetery object
# NOTE: sent here if cem_params not met in create method
#def new
#  @cemeteries = Cemetery.new
#end

# index action displays all cemetery records
def index
  @cemeteries = Cemetery.order("id_cem_lev ASC").all
end

# acquire param values from submit action, insert into outside sql database
def create
  @cemeteries = Cemetery.create(cem_params)
  if @cemeteries.save
    redirect_to @cemeteries
  else
    # redirect back to submit page
    render 'submit'
  end

end

# action queries the database for results
def search
  # invokve cemetery instance, retrieve one cemetery name
  @cemeteries = Cemetery.where(params[:cemetery]).take 
  # ensure result returned, otherwise reload page
  if @cemeteries.blank?
    render 'pages/_no_results'
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
  #render template: 'cemeteries/template',
   #      :locals => {:view => 'show'}
end


# use of AJAX to redner partial _submit view
def submit
  respond_to do |format|
    format.js
  end
end


private
  def cem_params
    allow = [:cem_name]
    params.require(:cemetery).permit(allow)
  end


end
