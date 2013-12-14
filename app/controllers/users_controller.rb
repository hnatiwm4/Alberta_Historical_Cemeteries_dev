class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit]
  before_action :correct_user, only: [:edit]
  before_action :admin_user, only: [:indes, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # sign_in @user
      user = @user # .find_by_email(params[:email])
      user.send_account_confirmation
      flash[:success] = "Welcome to the Alberta Historical Cemeteries Project! Please check your email to verify your account."
      redirect_to root_url
      # redirect_to @user
    else
      render 'new'
    end
  end

  def approve
    @user = User.find_by_id
    # @user = User.find_by_account_confirmation_token!(params[:id])
    @user.attributes = {:email_confirmed => true}
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, 
			:email, :password, :password_confirmation)
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
