# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Password resets controller that defines methods for object use
# ##############################################################################

class PasswordResetsController < ApplicationController
  def new
  end

  # this method sends a password reset url to the users email
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  # this method checks the time that the reset request was sent and if it is
  # older than two hours it will not allow resets
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
