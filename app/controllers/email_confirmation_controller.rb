class EmailConfirmationController < ApplicationController

def create
  user = User.find_by_email(params[:email])
  user.send_email_confirmation if user
  redirect_to root_url, :notice => "Please check your email to confirm your account."
end

def edit
  @user = User.find_by_account_confirmation_token!(params[:id])
end

def update
  @user = User.find_by_account_confirmation_token!(params[:id])
  if @user.update_attributes(user_params)
    redirect_to root_url, :notice => "Your account has been confirmed."
  else
    render :edit
  end
end

  private

  def user_params
    params.require(:user).permit(:email_confirmed)
  end
end
