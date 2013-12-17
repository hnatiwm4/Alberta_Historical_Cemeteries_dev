# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# User controller that defines methods for object use
# ##############################################################################

class UsersController < ApplicationController
  # restrict signed in user to edit action on own account
  before_action :signed_in_user, only: [:edit]
  # restrict correct user to edit action on own account
  before_action :correct_user, only: [:edit]
  # give admin user access to view all users and remove accounts
  before_action :admin_user, only: [:index, :destroy]

  # this method displays all users in the system and paginates the results
  # only available for admin users
  def index
    @users = User.paginate(page: params[:page])
  end

  # this method creates a user object from the id param
  def show
    @user = User.find(params[:id])
  end

  # this method creates a new user object
  def new
    @user = User.new
  end

  def edit
  end

  # this method updates the users first name, last name, and email
  # from the edit profile page
  def update
    @user = User.find_by_id(params[:id])
    @user.update_attribute(:first_name, user_params[:first_name])
    @user.update_attribute(:last_name, user_params[:last_name])
    @user.update_attribute(:email, user_params[:email])
    flash[:success] = "Profile updated"
    redirect_to @user
  end

  # this method creates a new user and sends an account confirmation to 
  # the users email.
  def create
    @user = User.new(user_params)
    if @user.save
      user = @user
      user.send_account_confirmation
      flash[:success] = "Welcome to the Alberta Historical Cemeteries Project! Please check your email to verify your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # this method modifies boolean value in db when email is confirmed
  def approve
    @user = User.find_by_id
    @user.attributes = {:email_confirmed => true}
  end

  def destroy
    # if user has associated records (FK constraints), dont delete and return error message (quick fix)
    @cemeteries = Cemetery.joins(:county).where(Cemetery.table_name+".`user_id`="+params[:id]).all
    @burials = Burial.where(Burial.table_name+".`user_id`="+params[:id]).all
    unless @burials.nil? || @cemeteries.nil?
      flash[:notice] = "Cannot Delete User, Foreign Key Constraint for records submitted"
      redirect_to :back and return
    end
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  #def profile
  #  @user = User.find(params[:id])
  #  respond_to do |format|
  #    format.js
  #  end
  #end

  #def submitted_data
  #  respond_to do |format|
  #    format.js
  #  end
  #end

  def submitted_data
    @cemeteries = Cemetery.joins(:county).where(Cemetery.table_name+".`user_id`="+params[:id]).all
    @burials = Burial.where(Burial.table_name+".`user_id`="+params[:id]).all
  end

  private

    # this method defines the accessable attributes
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
				:password, :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
