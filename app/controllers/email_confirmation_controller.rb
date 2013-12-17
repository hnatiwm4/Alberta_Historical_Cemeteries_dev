# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Email confirmation controller that defines methods for object use
# ##############################################################################

class EmailConfirmationController < ApplicationController

# this method sends an email to the user to confirm their address
def create
  user = User.find_by_email(params[:email])
  user.send_email_confirmation if user
  redirect_to root_url, :notice => "Please check your email to confirm your account."
end

def edit
  @user = User.find_by_account_confirmation_token!(params[:id])
end

# this method modifies a boolean in the db when email is confirmed
# allowing sign in
def update
  @user = User.find_by_account_confirmation_token!(params[:id])
  if @user.update_attribute(:email_confirmed, true)
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
