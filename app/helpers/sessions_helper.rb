# ##############################################################################
# Author: Michael Hnatiw & Patrick Sawyer-Bennett
# CMPT 498, Fall 2013 term
# Alberta Historical Cemeteries Project
# Sessions Helper defines common helper methods used by various 
# controllers and views
# ##############################################################################

module SessionsHelper

  # this method acts to set a token upon sign in that keeps the user signed
  # in between pages
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  # method for checking if a user is signed in
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  # this method defines what a current user is
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  # this method sets the current_user to nil and removes the remember token
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # this method sends the user back in the session
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
