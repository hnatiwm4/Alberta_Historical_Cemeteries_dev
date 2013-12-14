class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password]) 
      if user && user.email_confirmed == true
        sign_in user
        redirect_back_or user
      else
        flash.now[:error] = 'Account has not been confirmed. Please check your email.'
        render 'new'
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
