class BaseController < ApplicationController
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate
    if not current_user 
      redirect_to login_url 
    end  
  end

  helper_method :current_user  
end
